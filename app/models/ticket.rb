class Ticket < ApplicationRecord
  has_many :ticket_line_items, dependent: :destroy

  has_many :ticket_tags, dependent: :destroy
  has_many :clients, through: :ticket_tags

  validates_uniqueness_of :sb_bet_id

  scope :untagged, -> {
    find_by_sql("With TWT as
      ( SELECT t.*, sum(tt.amount) as amount_tagged
      FROM tickets t
      LEFT JOIN ticket_tags tt on t.id = tt.ticket_id
      GROUP BY t.id
      ORDER BY t.wager_date DESC )

      SELECT *
      FROM TWT
      WHERE coalesce(amount_tagged,0) <> amount_wagered")
  }

  scope :sorted, -> {
    sql = <<-SQL
      tickets.*,
      CASE
        WHEN (outcome IS NULL) THEN 1
        ELSE 2
      END as numeric_outcome
    SQL
    select(sql).order('numeric_outcome ASC, wager_date DESC')
  }

  def self.search(params)
    tickets = Ticket.order('wager_date DESC')
    if params[:page].to_i > 1
      limit = params.fetch(:limit, 0).to_i
      offset = (params[:page].to_i - 1) * limit
      tickets = tickets.limit(limit).offset(offset)
    end
    tickets
  end

  def as_vue
    self.as_json(methods: [:description], include: {ticket_tags: {methods: :tag_name} })
  end

  def amount_tagged
    self.ticket_tags.inject(0){|sum, tt| sum += tt.amount}
  end

  def amount_tagged_by(client)
    self.ticket_tags.where(client_id: client.id).inject(0) do |sum, tli|
      sum += tli.amount
    end
  end

  def description
    self.ticket_line_items.map do |tle|
      if self.outcome.nil? #pending
        if tle.away_team.blank? || tle.home_team.blank? #future bet
          tle.description
        else
          "#{tle.away_team} at #{tle.home_team} (#{tle.description})"
        end
      else
        if tle.away_team.blank? || tle.home_team.blank? #future bet
          tle.description
        else
          "#{tle.away_team} #{tle.away_score} at #{tle.home_team} #{tle.home_score} (#{tle.description})"
        end
      end
    end
  end

  def is_tagged?
    untagged_amount == 0
  end

  def lost?
    self.outcome =~ /lost/i
  end

  def untagged_amount
    (amount_wagered - amount_tagged).round(2)
  end

  def wager_date_display
    self.wager_date ? self.wager_date.strftime("%-m/%-d/%Y") : ""
  end

  def won?
    self.outcome =~ /won/i
  end

  # Save for a rainy day - Bad practice but I want to keep this knowledge

  # def self.tickets_won(client, start_date, stop_date)
  #   tickets_by_outcomes(client, start_date, stop_date, 'won', 'cashed out')
  # end

  # def self.tickets_by_outcomes(client, start_date, stop_date, *outcomes)
  #   TicketTag.joins(:ticket)
  #             .select("ticket_tags.*,
  #                 (ticket_tags.amount / tickets.amount_wagered) as ticket_percent,
  #                 ((ticket_tags.amount / tickets.amount_wagered) * tickets.amount_paid) as won_amount")
  #             .where("ticket_tags.client_id = ?
  #                 AND tickets.wager_date > ?
  #                 AND tickets.wager_date < ?
  #                 AND tickets.outcome in (?)",
  #                 client.id, start_date, stop_date, outcomes)
  # end

end

class TicketLineItem < ApplicationRecord
  belongs_to :ticket

  validates_uniqueness_of :line_item_date, scope: [:away_team, :home_team, :ticket_id, :description]
end

module Fixtures
  def self.no_pagination
    polish File.read("spec/files/no_pagination.html")
  end

  def self.raw_wager_data_2017
    polish File.read("spec/files/sb_response_2017.html")
  end

  def self.sb_super_bowl_2017
    polish File.read("spec/files/sb_super_bowl_2017.html")
  end

  def self.sb_super_bowl_2018
    polish File.read("spec/files/sb_super_bowl_2018.html")
  end

  def self.sb_response_3_line_items
    polish File.read("spec/files/sb_response_3_line_items.html")
  end

  def self.sb_pending
    polish File.read("spec/files/sb_pending_2018.html")
  end

  def self.sb_push
    polish File.read("spec/files/sb_push.html")
  end

  def self.bets_game_2019
    polish File.read("spec/files/bets_game_2019.html")
  end

  def self.bets_props_2019
    polish File.read("spec/files/bets_props_2019.html")
  end

  def self.bets_gatorade_bath_2019
    polish File.read("spec/files/bets_gatorade_bath_2019.html")
  end

  def self.polish(doc)
    doc.gsub!(/\\r|\\t|\\n|\\/, '')
    doc.gsub!(/\s{2,}/, ' ')
    Nokogiri::HTML(doc)
  end
end

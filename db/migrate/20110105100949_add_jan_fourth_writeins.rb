class AddJanFourthWriteins < ActiveRecord::Migration
  def self.up
    Choice.create!(:chain_id => 1, :label => "Edwin Lee", :term => "EdLee @sfmayoredlee Lee", :link => "http://www.sfgate.com/cgi-bin/article.cgi?f=/c/a/2011/01/05/BAUB1H46CD.DTL&feed=rss.news")
    Choice.create!(:chain_id => 1, :label => "Frank Chu", :term => "FrankChu Frank Chu", :link => "http://en.wikipedia.org/wiki/Frank_Chu")
    Choice.create!(:chain_id => 1, :label => "Brock Keeling", :term => "@brockder Brock Keeling BrockKeeling", :link => "http://www.sfweekly.com/bestof/2008/award/best-blogger-1033077/")
    
  end

  def self.down
  end
end

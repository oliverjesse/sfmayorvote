class AddJanFourthWriteins < ActiveRecord::Migration
  def self.up
    Choice.create!(:chain_id => 1, :label => "Edwin Lee", :term => "EdLee @sfmayoredlee Lee", :link => "http://www.sfgate.com/cgi-bin/article.cgi?f=/c/a/2011/01/05/BAUB1H46CD.DTL&feed=rss.news")
    Choice.create!(:chain_id => 1, :label => "Frank Chu", :term => "FrankChu Frank Chu", :link => "http://en.wikipedia.org/wiki/Frank_Chu")
    
  end

  def self.down
  end
end

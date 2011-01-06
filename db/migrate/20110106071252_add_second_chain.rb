class AddSecondChain < ActiveRecord::Migration
  def self.up
    Chain.first.update_attribute(:active, false)
    c = Chain.new(:term => "#sfmayor #vote")
    c.choices << [
      Choice.new(:label => "Edwin Lee", :term => "EdLee @sfmayoredlee Edwin Ed Lee", :link => "http://www.sfgate.com/cgi-bin/article.cgi?f=/c/a/2011/01/05/BAUB1H46CD.DTL&feed=rss.news"),
      Choice.new(:label => "Art Agnos", :term => "@ArtAgnos ArtAgnos Art Agnos", :link => "http://en.wikipedia.org/wiki/Art_Agnos"),
      Choice.new(:label => "Mike Hennessey", :term => "MikeHennessey Mike Hennessey", :link => "http://www.sfsheriff.com/sheriff.htm")
    ]
    c.save
  end

  def self.down
  end
end

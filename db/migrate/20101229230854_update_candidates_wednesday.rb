class UpdateCandidatesWednesday < ActiveRecord::Migration
  def self.up
    Choice.create!(:chain_id => 1, :label => "Leslie Katz", :term => "LeslieKatz @lrkatz Katz", :link => "")
    Choice.create!(:chain_id => 1, :label => "Michael Yaki", :term => "@YakiBlog MichaelYaki Yaki", :link => "http://en.wikipedia.org/wiki/Michael_Yaki")
    Choice.create!(:chain_id => 1, :label => "Nate Ballard", :term => "@NateBallard NateBallard Nate Ballard", :link => "http://earned-media.com/")
    Choice.create!(:chain_id => 1, :label => "Bob Muscat", :term => "@BobMuscat BobMuscat Muscat", :link => "")
    Choice.create!(:chain_id => 1, :label => "John Dennis", :term => "@JohnDennis2010 JohnDennis", :link => "http://en.wikipedia.org/wiki/John_Dennis_(California_politician)")
    Choice.create!(:chain_id => 1, :label => "Dionne Warwick", :term => "DionneWarwick Warwick", :link => "http://en.wikipedia.org/wiki/Dionne_Warwick")
    Choice.create!(:chain_id => 1, :label => "Able Dart", :term => "@AbleDart AbleDart Dart", :link => "http://sfwall.blogspot.com/")
    Choice.create!(:chain_id => 1, :label => "Chris Daly", :term => "@superdaly ChrisDaly Daly", :link => "http://en.wikipedia.org/wiki/Chris_Daly")
  end

  def self.down
  end
end
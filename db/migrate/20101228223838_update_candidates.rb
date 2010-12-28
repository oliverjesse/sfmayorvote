class UpdateCandidates < ActiveRecord::Migration
  def self.up
    Choice.create!(:chain_id => 1, :label => "Phil Ting", :term => "@PhilTing PhilTing Ting", :link => "http://en.wikipedia.org/wiki/Phil_Ting")
    Choice.create!(:chain_id => 1, :label => "Leland Yee", :term => "@LelandYee LelandYee Yee", :link => "http://en.wikipedia.org/wiki/Leland_Yee")
    Choice.create!(:chain_id => 1, :label => "Michela Alioto-Pier", :term => "@MichelaAliotoPier MichelaAliotoPier @MichelaAlioto-Pier MichelaAlioto-Pier Michela Alioto-Pier AliotoPier", :link => "http://en.wikipedia.org/wiki/Michela_Alioto-Pier")
    Choice.create!(:chain_id => 1, :label => "Eric Mar", :term => "@eric415 EricMar Mar", :link => "http://en.wikipedia.org/wiki/Eric_Mar")
    Choice.create!(:chain_id => 1, :label => "Marcy Berry", :term => "@MarcyBerry MarcyBerry Marcy Berry", :link => "http://www.lpsf.org/contact-us/officers/34-officers/5-marcy-berry.html")
    Choice.where(:label => "Mike Hennessey").first.update_attribute(:link, "http://www.sfsheriff.com/sheriff.htm")
    Choice.where(:label => "Ed Harrington").first.update_attribute(:link, "http://sfwater.org/dept.cfm/mo_id/67")
  end

  def self.down
  end
end

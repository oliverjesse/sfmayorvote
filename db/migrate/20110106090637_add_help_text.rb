class AddHelpText < ActiveRecord::Migration
  def self.up
    Chain.find(1).update_attribute(:headline, "Who should be interim SF Mayor?")
    Chain.find(1).update_attribute(:intro, "On January 3, 2011, current San Francisco mayor Gavin Newsom becomes California Lieutenant Governor. The Board of Supervisors gets to choose his replacement. Tell them how you'd vote.")
    Chain.find(1).update_attribute(:outro, "Don't see your pick? Tweet their name with #sfmayor #vote anyway.<br />We'll check for new contenders daily and add them here.")
    Chain.find(2).update_attribute(:headline, "Who should be interim SF Mayor?")
    Chain.find(2).update_attribute(:intro, "On January 4, the Board of Supervisors narrowed its interim mayor nominees to the three candidates below.  They'll meet again on January 7.  Tell them how you'd vote.")
    Chain.find(2).update_attribute(:outro, "In view of the Supervisors' nominations of January 4, we are not counting write-ins on this poll.")
  end

  def self.down
  end
end

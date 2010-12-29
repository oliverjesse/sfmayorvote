namespace :tweets do
  task :rescore => :environment do
    Tweet.where(:scored => false).find_each do |tweet|
      tweet.send(:set_defaults)
      tweet.score
      tweet.save!
      print '.'
    end
    puts
  end
end

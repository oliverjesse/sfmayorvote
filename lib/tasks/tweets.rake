namespace :tweets do
  task :rescore_all => :environment do
    Vote.destroy_all

    Tweet.order('tweeted_at ASC').find_each do |tweet|
      tweet.refresh_associations
      tweet.score
      tweet.save!
      print '.'
    end
    puts
  end
end

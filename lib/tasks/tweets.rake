namespace :tweets do
  task :rescore_all => :environment do
    Vote.destroy_all

    Tweet.order('created_at ASC').find_each do |tweet|
      tweet.refresh_associations
      tweet.score
      tweet.save!
      print '.'
    end
    puts
  end

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

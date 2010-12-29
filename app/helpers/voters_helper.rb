module VotersHelper
  def voter_profile_image(voter)
    voter.profile_image_url.present? ? voter.profile_image_url : 'portrait_mini.jpg'
  end

  def voter_profile_url(voter)
    "http://twitter.com/#{voter.screen_name}"
  end
end
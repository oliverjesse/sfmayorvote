module VotersHelper
  def voter_profile_image(voter)
    voter.profile_image_url.present? ? voter.profile_image_url : 'portrait_mini.jpg'
  end
end
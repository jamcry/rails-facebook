module UsersHelper
  # Returns the Gravatar (image) of given user
  def gravatar_for(user, params = { size: 50 })
    gravatar_id  = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{params[:size]}"
    image_tag(gravatar_url, alt: "#{user.first_name}'s gravatar", class: "gravatar rounded rounded-circle img-fluid d-block")
  end
end

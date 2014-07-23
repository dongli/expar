module UsersHelper
  def get_user_name(user)
    return "#{user.first_name} #{user.last_name}"
  end

  def get_admin_email
    return User.find(1).email
  end

  def get_gravatar(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://www.gravatar.com/avatar.php?"
    gravatar_url << "gravatar_id=#{gravatar_id}"
    gravatar_url << "&size=160px"
    image_tag(gravatar_url, alt: get_user_name(user), class: "gravatar")
  end
end

module UsersHelper
  def get_user_name(user)
    return "#{user.first_name} #{user.last_name}"
  end

  def get_admin_email
    return User.find(1).email
  end
end

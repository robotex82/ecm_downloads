module ActiveAdmin::SignInHelper
  def sign_in(admin_user)
    post admin_user_session_path, {
      :admin_user => {
        :email    => admin_user.email,
        :password => admin_user.password
      }
    }
  end
end

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
# See https://github.com/omniauth/omniauth/wiki/FAQ#rails-session-is-clobbered-after-callback-on-developer-strategy

  skip_before_action :verify_authenticity_token, only: [:github, :wechat]

  def github
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = AuthProvider.find_for_github_oauth(request.env["omniauth.auth"])
    if @user.persisted?
      set_flash_message(:notice, :success, kind: "github") if is_navigational_format?
      cookies[:u] = { value: Digest::MD5.hexdigest(@user.id.to_s), expires: Time.now + 3600, domain: :all}
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
    else
      session["devise.github_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url
    end
  end

  def wechat
    puts request.env["omniauth.auth"]
    @user = AuthProvider.find_for_wechat_oauth(request.env["omniauth.auth"])
    if @user.persisted?
      set_flash_message(:notice, :success, kind: "wechat") if is_navigational_format?
      cookies[:u] = { value: @user.id.to_s, expires: Time.now + 3600, domain: :all}
      sign_in_and_redirect @user, :event => :authentication
      # redirect_to 'https://www.2mui.cn/callback' and return
    else
      session["devise.wechat_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  def after_sign_in_path_for(resource)
    "https://www.2mui.cn/" || request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end
end

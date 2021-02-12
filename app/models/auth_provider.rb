class AuthProvider < ApplicationRecord
  belongs_to :user

  def self.from_omniauth(auth)
    auth_provider = AuthProvider.where(:provider => auth.provider, :uid => auth.uid).first
    unless auth_provider.nil?
      auth_provider.user
    else
      # ap = AuthProvider.where(uid: auth.uid).first
      # registered_user = ap.User
      registered_user = User.where(:email => auth.info.email).first
      unless registered_user.nil?
        AuthProvider.create!(
          provider: auth.provider,
          uid: auth.uid,
          user_id: registered_user.id
        )
        registered_user
      else
        user = User.create!(
          name: auth.info.name,
          email: auth.info.email || "#{SecureRandom.hex(5)}@2mui.cn",
          password: Devise.friendly_token[0,20],
        )
        AuthProvider.create!(
          provider: auth.provider,
          uid:  auth.uid,
          user_id: user.id
        )
        user
      end
    end
  end
  
  def self.find_for_wechat_oauth(auth)
    self.from_omniauth(auth)
  end

  def self.find_for_github_oauth(auth)
    self.from_omniauth(auth)
  end
end

# http://jorge.caballeromurillo.com/multiple-omniauth-providers-for-same-user-on-ruby-on-rails/
# https://github.com/omniauth/omniauth/wiki/Managing-Multiple-Providers
# https://github.com/heartcombo/devise/wiki/OmniAuth-with-multiple-models
# https://github.com/heartcombo/devise/wiki/OmniAuth:-Overview

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :wechat, ENV['WECHAT_APP_ID'], ENV['WECHAT_APP_SECRET'],
    # :authorize_params => {:redirect_uri => "https://3ae95d3fa62b.ngrok.io/auth/wechat/callback"},
    :authorize_params => {:redirect_uri => "https://auth.2mui.cn/auth/wechat/callback"},
    provider_ignores_state: true
  
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET'], scope: "user"
end

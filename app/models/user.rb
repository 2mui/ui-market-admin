class User < ApplicationRecord
  has_person_name

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
        
        # prefer to config omniauth in config/initializers/omniauth.rb not devise.rb
        # https://github.com/heartcombo/devise/wiki/OmniAuth:-Overview
        # https://github.com/heartcombo/devise/wiki/OmniAuth-with-multiple-models
        :omniauthable, omniauth_providers: [:github, :wechat]

  validates :email, presence: true, uniqueness: true
  has_many :auth_providers, dependent: :destroy
end

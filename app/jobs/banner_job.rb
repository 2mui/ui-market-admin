require 'aliyun/oss'

class BannerJob < ApplicationJob
  queue_as :default

  def perform(banner_id)
    banner = Banner.find(banner_id)
    if Rails.env.development?
      url = "http://localhost:5000"
    else
      url = "https://assets.2mui.cn"
    end

    ActiveStorage::Current.set(host: url) do
      if banner.image.attached? && banner.image.image?
        banner.update_column(:image, banner.image.variant(resize_to_limit: [nil,600]).processed.url) 
      end
    end
  end
end
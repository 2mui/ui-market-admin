require 'aliyun/oss'

class ItemJob < ApplicationJob
  queue_as :default

  def perform(item_id)
    item = Item.find(item_id)
    if Rails.env.development?
      url = "http://localhost:5000"
    else
      url = "https://assets.2mui.cn"
    end

    # https://stackoverflow.com/questions/51110789/activestorage-service-url-rails-blob-path-cannot-generate-full-url-when-not-u
    # https://stackoverflow.com/questions/14880931/how-to-update-multiple-columns-in-ruby-on-rails-3/25171212
    ActiveStorage::Current.set(host: url) do
      if item.cover.attached? && item.cover.image?
        item.update_column(:cover, item.cover.variant(resize_to_limit: [404,303]).processed.url) 
      end
      if item.detail.attached? && item.cover.image?
        item.update_column(:detail, item.detail.variant(resize_to_limit: [1292, nil]).processed.url)
      end
      item.update_column(:url, item.url.url) if item.url.attached?
      item.update_column(:filesize, item.url.byte_size) if item.url.attached?
    end

    if item.url.attached?
      ext_lists = [".sketch", ".xd", ".psd", ".ai", ".eps"]

      # 如果是上传的是上述文件后缀的文件 那么就调用oss api设置object的HTTP HEADER
      if ext_lists.include? item.url.blob.filename.extension_with_delimiter
        set_content_disposition_for_object item.url.blob
      end
    end

  end

  def set_content_disposition_for_object(blob)
    client = Aliyun::OSS::Client.new(
      endpoint: 'https://oss-cn-shenzhen.aliyuncs.com',
      access_key_id: ENV["ALIYUN_ACCESS_KEY_ID"], 
      access_key_secret: ENV["ALIYUN_ACCESS_KEY_SECRET"]
    )
    bucket = client.get_bucket('ui-market')
    bucket.put_object(blob.key, headers: {'Content-Disposition' => "attachment; filename=#{blob.filename.to_s}"})
  end
end

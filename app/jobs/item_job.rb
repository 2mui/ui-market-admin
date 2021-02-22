class ItemJob < ApplicationJob
  queue_as :default

  def perform(item_id)
    item = Item.find(item_id)
    if Rails.env.development?
      url = "http://localhost:5000"
    else
      url = "https://assets.2mui.cn"
    end

    p item
    p url

    # https://stackoverflow.com/questions/51110789/activestorage-service-url-rails-blob-path-cannot-generate-full-url-when-not-u
    # https://stackoverflow.com/questions/14880931/how-to-update-multiple-columns-in-ruby-on-rails-3/25171212
    ActiveStorage::Current.set(host: url) do
      item.update_column(:cover, item.cover.url) if item.cover.attached?
      item.update_column(:detail, item.detail.url) if item.detail.attached?
      item.update_column(:url, item.url.url) if item.url.attached?
      item.update_column(:filesize, item.url.byte_size) if item.url.attached?
    end
  end
end

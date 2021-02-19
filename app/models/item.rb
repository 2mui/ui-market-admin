class Item < ApplicationRecord
  has_one_attached :cover
  has_one_attached :detail
  has_one_attached :url
  
  validates :title, presence: true
  after_create :fix_image_urls

  # FILETYPES = ["PSD", "XD", "AI", "Sketch"]
  # Item.last.update_column(:cover, Item.last.cover.service_url)
  def fix_image_urls
    if Rails.env.development?
      ActiveStorage::Current.set(host: "http://localhost:3000") do
        self.update_column(:cover, self.cover.service_url)
        self.update_column(:detail, self.detail.service_url)
        self.update_column(:url, self.url.service_url)
      end
    else
      # https://stackoverflow.com/questions/51110789/activestorage-service-url-rails-blob-path-cannot-generate-full-url-when-not-u
      ActiveStorage::Current.set(host: "http://assets.2mui.cn") do
        self.update_column(:cover, self.cover.service_url)
        self.update_column(:detail, self.detail.service_url)
        self.update_column(:url, self.url.service_url)
      end
    end
    
  end
end

class Item < ApplicationRecord
  has_one_attached :cover
  has_one_attached :detail
  has_one_attached :url
  
  validates :title, presence: true
  after_create :update_real_url_and_filesize
  after_update :update_real_url_and_filesize

  # TODO: improve to sidekiq job
  # number_to_human_size
  # because cover(has_one_attached) is activestorage field and it's an object and nil in column
  # so it should be updated for hasura graphql query
  # Item.last.update_column(:cover, Item.last.cover.service_url)
  def update_real_url_and_filesize
    if Rails.env.development?
      ActiveStorage::Current.set(host: "https://localhost:5000") do
        self.update_column(:cover, self.cover.service_url)
        self.update_column(:detail, self.detail.service_url)
        self.update_column(:url, self.url.service_url)
        self.update_column(:filesize, self.url.byte_size)
      end
    else
      # https://stackoverflow.com/questions/51110789/activestorage-service-url-rails-blob-path-cannot-generate-full-url-when-not-u
      ActiveStorage::Current.set(host: "https://assets.2mui.cn") do
        self.update_column(:cover, self.cover.service_url)
        self.update_column(:detail, self.detail.service_url)
        self.update_column(:url, self.url.service_url)
        self.update_column(:filesize, self.url.byte_size)
      end
    end 
  end
end

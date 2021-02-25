class Item < ApplicationRecord
  has_one_attached :cover
  has_one_attached :detail
  has_one_attached :url
  
  validates :title, presence: true
  after_commit :update_real_url_and_filesize, on: :create
  after_commit :update_real_url_and_filesize, on: :update

  belongs_to :category
  belongs_to :industry
  belongs_to :user, class_name: "User", foreign_key: "upload_by"

  # TODO: improve to sidekiq job
  # number_to_human_size
  # because cover(has_one_attached) is activestorage field and it's an object and nil in column
  # so it should be updated for hasura graphql query
  # Item.last.update_column(:cover, Item.last.cover.service_url)
  def update_real_url_and_filesize
    ItemJob.perform_later id
  end

  def published?
    !draft
  end

  def featured?
    featured
  end

end

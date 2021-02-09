class Item < ApplicationRecord
  has_one_attached :cover
  has_one_attached :detail
  has_one_attached :url
  
  validates :title, presence: true
end

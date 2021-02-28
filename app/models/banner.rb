class Banner < ApplicationRecord
    include Discard::Model
    default_scope -> { kept }

    has_one_attached :image
    after_commit :update_real_url, on: :create
    after_commit :update_real_url, on: :update

    def update_real_url
        BannerJob.perform_later id
    end
end

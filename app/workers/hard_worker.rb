class HardWorker
  include Sidekiq::Worker
  
  def perform
    logger.info "Things are happening."
    items = Item.where(cover: nil).or(Item.where(detail: nil)).or(Item.where(url: nil))
    items.each do |item|
      ItemJob.perform_now(item.id)
    end
  end
end

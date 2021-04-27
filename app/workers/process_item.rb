class ProcessItem
  include Sidekiq::Worker
  
  def perform(*args)
    item = ResourceDetail.where(processed: false).first
    if item.present?
      puts item
    end
  end
end

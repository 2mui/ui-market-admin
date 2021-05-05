class ProcessItem
  include Sidekiq::Worker
  
  def perform(*args)
    rd = ResourceDetail.where(processed: false).where("cover != '' AND detail != '' AND url != ''").first
    if rd.present?
      puts rd
      item = ResourceDetail.new(
        title: rd.title, 
        description: rd.description, 
        draft: true, 
        featured: false,
        upload_by: 1,
        category_id: Category.where(name: "其他").first.try(:id), 
        industry_id: Industry.where(name: "其他").first.try(:id)
      )
      item.save!
      attach_from_remote(item, rd.cover)
      attach_from_remote(item, rd.detail)
      attach_from_remote(item, rd.url)
    end
  end

  def attach_from_remote(obj, field, url)
    require 'open-uri'
    filename = File.basename(URI.parse(url).path)
    file = URI.open(url)
    obj.send(field.to_sym).attach(io: file, filename: filename )
    # rd.cover.attach(io: file, filename: filename )
  end
end



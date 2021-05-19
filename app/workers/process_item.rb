class ProcessItem
  include Sidekiq::Worker
  
  def perform(*args)
    puts "args: #{args}"
    rd = ResourceDetail.where(processed: false).where("cover != '' AND detail != '' AND url != ''").first
    # rd = ResourceDetail.where(id: id).first
    if rd.present?
      puts rd
      item = Item.new(
        title: rd.title, 
        description: rd.description, 
        draft: true, 
        featured: false,
        upload_by: 1,
        category_id: Category.where(name: "其他").first.try(:id), 
        industry_id: Industry.where(name: "其他").first.try(:id)
      )
      attach_from_remote(item, :cover, rd.cover)
      attach_from_remote(item, :detail, rd.detail)
      attach_from_remote(item, :url, rd.url)

      if rd.filetypes.present?
        filetypes = rd.filetypes.split(",").each do |x|
          x.gsub!(".","")
        end
        filetypes.unshift("")
        item.filetype = filetypes
      end

      item.save!

      ItemJob.perform_later(item.id)

      rd.update(processed: true)
    end
  end

  def attach_from_remote(obj, field, url)
    require 'open-uri'
    filename = File.basename(URI.parse(url).path)
    file = URI.open("https://" + url)
    obj.send(field.to_sym).attach(io: file, filename: filename )
    # rd.cover.attach(io: file, filename: filename )
  end
end



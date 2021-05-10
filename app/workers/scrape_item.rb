# -*- coding: UTF-8 -*-
require 'tencentcloud-sdk-common'
require 'tencentcloud-sdk-scf'

include TencentCloud::Common
include TencentCloud::Scf::V20180416

require "ostruct"

class ScrapeItem
  include Sidekiq::Worker
  
  def perform
    item = ResourceItem.where(scraped: false).first
    if item.present?
      begin
        cre = Credential.new(ENV['TENCENT_CLOUD_APP_KEY'], ENV['TENCENT_CLOUD_APP_SECRET'])
        cli = Client.new(cre, 'ap-singapore')
        
        param = OpenStruct.new
        param.type = "item"
        param.url  = item.link
        
        req = InvokeRequest.new("fdr", "RequestResponse", "$LATEST", param.to_h.to_json)
        resp = cli.Invoke(req)
        
        puts resp.serialize
        puts "RequestId: #{resp.RequestId}"

        if resp.Result == 0
          item.update!(scraped: true)
          ProcessItem.perform_async(item.id)
        end

      rescue TencentCloudSDKException => e
        puts e.message  
        puts e.backtrace.inspect  
      end
      
      logger.info "Scraping resource detail for an item ......"
    end
  end
end

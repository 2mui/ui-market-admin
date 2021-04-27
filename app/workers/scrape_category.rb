# -*- coding: UTF-8 -*-
require 'tencentcloud-sdk-common'
require 'tencentcloud-sdk-scf'

include TencentCloud::Common
include TencentCloud::Scf::V20180416

require "ostruct"

class ScrapeCategory
  include Sidekiq::Worker
  
  def perform(*args)
    category = ResourceCategory.all.first
    if category.present?
      begin
        cre = Credential.new(ENV['TENCENT_CLOUD_APP_KEY'], ENV['TENCENT_CLOUD_APP_SECRET'])
        cli = Client.new(cre, 'ap-singapore')
        
        param = OpenStruct.new
        param.type = "category"
        param.url  = category.link_to_extract

        req = InvokeRequest.new("fdr", "RequestResponse", "$LATEST", param.to_h.to_json)
        resp = cli.Invoke(req)
        puts resp.serialize
      
      rescue TencentCloudSDKException => e
        puts e.message  
        puts e.backtrace.inspect  
      end
  
      logger.info "Scraping resource items links from one category ......"
    end
  end
end

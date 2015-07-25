require 'aws-sdk-resources'
require 'net/http'

class MainController < ApplicationController

  def landing
    s3 = Aws::S3::Resource.new
    obj = s3.bucket('grafiore').object('鳥の詩.mp3')
    url = URI.parse(obj.presigned_url(:get))
    
    @src = Rails.env.development? ? "" : url
    #s3.get_object({bucket: "grafiore", key: "鳥の詩.mp3"})
  end

end

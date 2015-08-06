require 'aws-sdk-resources'
require 'net/http'

class MainController < ApplicationController

  def landing
    s3 = Aws::S3::Resource.new
    obj = s3.bucket('grafiore').object('鳥の詩.mp3')
    url = URI.parse(obj.presigned_url(:get))
    
    if Rails.env.development?
      #@src = ["/assets/会いたい.mp3", "/assets/tori-no-uta.mp3"]
      @abs_src = ["app/assets/audios/会いたい.mp3", "app/assets/audios/tori-no-uta.mp3"]
    else
      @abs_src = [url]
    end

    @music = Music.create_music_files(@abs_src)

  end

end

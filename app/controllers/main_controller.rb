require 'aws-sdk-resources'
require 'net/http'

class MainController < ApplicationController

  def landing
    if Rails.env.development?
      #@src = ["/assets/会いたい.mp3", "/assets/tori-no-uta.mp3"]
      @abs_src = ["app/assets/audios/会いたい.mp3", "app/assets/audios/tori-no-uta.mp3"]
    else
      s3 = Aws::S3::Resource.new
      @abs_src = []
      s3.bucket('grafiore').objects.each do |music|
        @abs_src << URI.parse(music.presigned_url(:get))
      end
    end

    @music = Music.create_music_files(@abs_src)

  end

end

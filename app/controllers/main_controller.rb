require 'aws-sdk-resources'
require 'net/http'

class MainController < ApplicationController

  def landing
    #if Rails.env.development?
    @abs_src = ["app/assets/audios/会いたい.mp3", "app/assets/audios/tori-no-uta.mp3", "app/assets/audios/no-album-cover.mp3"]
    #else

    #taglib only works on local files..!
      # s3 = Aws::S3::Resource.new
      # signer = Aws::S3::Presigner.new
      # @abs_src = []
      # s3.bucket('grafiore').objects({prefix: "music"}).drop(1).each do |music|
      #   #URI.parse?
      #   @abs_src << URI.parse(signer.presigned_url(:get_object, bucket: 'grafiore', key: music.key))
      # end
    #end

    @music = Music.create_music_files(@abs_src)

  end

end

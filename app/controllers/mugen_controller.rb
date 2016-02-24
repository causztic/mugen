require 'aws-sdk-resources'
require 'net/http'

class MugenController < ApplicationController

  def show
    @abs_src = Dir.glob('app/assets/audios/*').select {|f| File.file? f}
    @music = Music.create_music_files(@abs_src)
    gon.music = @music
  end

end

require 'aws-sdk-resources'
require 'net/http'

class MainController < ApplicationController

  def landing
    @abs_src = Dir.glob('app/assets/audios/*').select {|f| File.file? f}
    @music = Music.create_music_files(@abs_src)
    if Rails.env.production? 
      @music = @music.each {|m| m.path = view_context.asset_path(m.path)}
    else
      @music = @music.each {|m| m.path = "/assets/" + m.path }
    end
    gon.music = @music
  end

end

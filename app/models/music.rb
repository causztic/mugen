require 'taglib'
class Music

  attr_accessor :title, :artist, :cover_image, :path, :album, :id

  def self.create_music_files(abs_src)
    @files = []
    abs_src.each_with_index do |f, index|
      m = Music.new
      TagLib::MPEG::File.open(f) do |file|
        @tag = file.id3v2_tag
        m.title = @tag.title
        m.artist = @tag.artist
        m.album = @tag.album
        cover = @tag.frame_list('APIC').first
        m.cover_image = cover.nil? ? "http://placehold.it/300x300" : "data:#{cover.mime_type};base64,#{Base64.encode64(cover.picture)}"
      end
      f["app/assets/audios/"] = ""
      m.path = Rails.env.production? ?  "assets/" + Rails.application.assets.find_asset(f).digest_path : "assets/" + f
      m.id = index
      @files << m
    end
    return @files
  end

end

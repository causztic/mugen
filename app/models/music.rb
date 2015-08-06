class Music

  attr_accessor :title, :artist, :cover_image, :path

  def self.create_music_files(abs_src)
    @files = []
    abs_src.each do |f|
      m = Music.new
      TagLib::MPEG::File.open(f) do |file|
        @tag = file.id3v2_tag
        m.title = @tag.title
        m.artist = @tag.artist
        cover = @tag.frame_list('APIC').first
        m.cover_image = "data:#{cover.mime_type};base64, #{Base64.encode64(cover.picture)}"
      end
      f ["app/"] = "/"
      f ["/audios/"] = "/"
      m.path = f
      @files << m
    end
    return @files
  end

end

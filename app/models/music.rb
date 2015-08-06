class Music

  attr_accessor :title, :artist, :cover_image

  def self.create_music_file(abs_src)

    m = Music.new
    TagLib::MPEG::File.open(abs_src) do |file|
      @tag = file.id3v2_tag
      m.title = @tag.title
      m.artist = @tag.artist
      cover = @tag.frame_list('APIC').first
      m.cover_image = "data:#{cover.mime_type};base64, #{Base64.encode64(cover.picture)}"
    end
    return m
  end

end

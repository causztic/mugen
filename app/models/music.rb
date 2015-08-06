class Music

  attr_accessor :title, :artist

  def self.create_music_file(abs_src)

    m = Music.new
    TagLib::MPEG::File.open(abs_src) do |file|
      @tag = file.id3v2_tag
      m.title = @tag.title
      m.artist = @tag.artist
    end
    return m
  end

end

class Album

  attr_accessor :name, :year, :id, :genre, :artist, :status

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id).to_i
    @year = attributes.fetch(:year).to_i
    @genre = attributes.fetch(:genre)
    @artist = attributes.fetch(:artist)
    @status = attributes.fetch(:status)
  end

  def self.all()
    returned_albums = DB.exec("SELECT * FROM albums;")
    albums = []
    returned_albums.each() do |album|
      name = album.fetch("name")
      id = album.fetch("id").to_i
      year = album.fetch("year").to_i
      genre = album.fetch("genre")
      artist = album.fetch("artist")
      status = album.fetch("status")
      albums.push(Album.new({:name => name, :id => id, :year => year, :genre => genre, :artist => artist, :status => status}))
    end
    albums.sort { |a, b| a.name.downcase <=> b.name.downcase }
  end

  def save
    result = DB.exec("INSERT INTO albums (name, year, genre, artist, status) VALUES ('#{@name}', '#{@year}', '#{@genre}', '#{@artist}', '#{@status}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.clear
    DB.exec("DELETE FROM albums *;")
  end

  def self.find(id)
    album = DB.exec("SELECT * FROM albums WHERE id = #{id};").first
    name = album.fetch("name")
    id = album.fetch("id").to_i
    year = album.fetch("year").to_i
    genre = album.fetch("genre")
    artist = album.fetch("artist")
    status = album.fetch("status")
    Album.new({:name => name, :id => id, :year => year, :genre => genre, :artist => artist, :status => status})
  end

  def self.search_name(name)
    albums = self.all
    albums.select { |album| /#{name}/i.match? album.name }
  end

  def update(name, year, genre, artist)
    @name = name
    @year = year
    @genre = genre
    @artist = artist
    DB.exec("UPDATE albums SET name = '#{@name}', year = '#{@year}', genre = '#{@genre}', artist = '#{@artist}' WHERE id = #{id};")
  end

  def delete()
    DB.exec("DELETE FROM albums WHERE id = #{@id};")
  end

  def sold()
    @status = false
    DB.exec("UPDATE albums SET status = '#{@status}' WHERE id = #{id};")
  end

  def songs
    Song.find_by_album(self.id)
  end

end

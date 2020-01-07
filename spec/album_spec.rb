require('rspec')
require('album.rb')
require 'spec_helper'

describe '#Album' do

  describe('.all') do
    it("returns an empty array when there are no albums") do
      expect(Album.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an album") do
      album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre => "bluegrass", :artist => "old mcdonald", :status => true, :cost => 4.99})
      album.save()
      album2 = Album.new({:name => "Blue", :id => nil, :year => 1990, :genre => "pop", :artist => "Aba", :status => true, :cost => 4.99})
      album2.save()
      expect(Album.all).to(eq([album, album2]))
    end
  end

  describe('#==') do
    it("is the same album if it has the same attributes as another album") do
      album = Album.new({:name => "Blue", :id => nil, :year => 1990, :genre => "pop", :artist => "Aba", :status => true, :cost => 4.99})
      album2 = Album.new({:name => "Blue", :id => nil, :year => 1990, :genre => "pop", :artist => "Aba", :status => true, :cost => 4.99})
      expect(album).to(eq(album2))
    end
  end

  describe('.clear') do
    it("clears all albums") do
      album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre => "bluegrass", :artist => "old mcdonald", :id => nil, :status => true, :cost => 4.99})
      album.save()
      album2 = Album.new({:name => "Blue", :id => nil, :year => 1990, :genre => "pop", :artist => "Aba", :status => true, :cost => 4.99})
      album2.save()
      Album.clear()
      expect(Album.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an album by id") do
      album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre => "bluegrass", :artist => "old mcdonald", :status => true, :cost => 4.99})
      album.save()
      album2 = Album.new({:name => "Blue", :id => nil, :year => 1990, :genre => "pop", :artist => "Aba", :status => true, :cost => 4.99})
      album2.save()
      # binding.pry
      expect(Album.find(album.id)).to(eq(album))
    end
  end

  # describe('.search_name') do
  #   it("finds an album by name") do
  #     album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre => "bluegrass", :artist => "old mcdonald", :status => true})
  #     album.save()
  #     album2 = Album.new({:name => "Blue", :id => nil, :year => 1990, :genre => "pop", :artist => "Aba", :status => true})
  #     album2.save()
  #     expect(Album.search_name(album.name)).to(eq([album]))
  #   end
  # end

  describe('#update') do
    it("updates an album by id") do
      album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre => "bluegrass", :artist => "old mcdonald", :status => true, :cost => 4.99})
      album.save()
      album.update("A Love Supreme", 2000, "bluegrass", "old mcdonald", 4.99)
      expect(album.name).to(eq("A Love Supreme"))
    end
  end

  describe('#delete') do
    it("deletes an album by id") do
      album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre => "bluegrass", :artist => "old mcdonald", :status => true, :cost => 4.99})
      album.save()
      album2 = Album.new({:name => "Blue", :id => nil, :year => 1990, :genre => "pop", :artist => "Aba", :status => true, :cost => 4.99})
      album2.save()
      album.delete()
      expect(Album.all).to(eq([album2]))
    end
  end

  # describe('#sold') do
  #   it("changes the status of the album") do
  #     album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre => "bluegrass", :artist => "old mcdonald", :status => true})
  #     album.save()
  #     album.sold()
  #     expect(album.status).to(eq("sold"))
  #   end
  # end

  describe('#songs') do
    it("returns an album's songs") do
      @album = Album.new({:name => "Giant Steps", :id => nil, :year => 2000, :genre => "bluegrass", :artist => "old mcdonald", :status => true, :cost => 4.99})
      @album.save()
      song = Song.new({:name =>"Naima", :album_id => @album.id, :id => nil})
      song.save()
      song2 = Song.new({:name => "California", :album_id => @album.id, :id => nil})
      song2.save()
      expect(@album.songs).to(eq([song, song2]))
    end
  end


end

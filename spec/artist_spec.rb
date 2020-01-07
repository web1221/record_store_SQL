require 'rspec'
require 'album.rb'
require 'spec_helper'

describe('#update') do
  it("adds an album to an artist") do
    artist = Artist.new({:name => "John Coltrane", :id => nil})
    artist.save()
    album = Album.new({:name => "A Love Supreme", :id => nil, :year => 2000, :genre => "bluegrass", :artist => "old mcdonald", :status => true, :cost => 4.99})
    album.save()
    artist.update({:name => "Timer", :album_name => "A Love Supreme"})
    expect(artist.albums).to(eq([album]))
  end
end

describe('#delete') do
  it("deletes artist from artists db and albums_artists join table") do
    artist = Artist.new({:name => "Giant Steps", :id => nil})
    artist.save()
    artist2 = Artist.new({:name => "Steps", :id => nil})
    artist2.save()
    artist.delete()
    expect(Artist.all).to(eq([artist2]))
end
end

##delete test failing

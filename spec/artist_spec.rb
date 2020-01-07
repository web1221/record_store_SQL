require 'rspec'
require 'album.rb'
require 'spec_helper'

describe('#update') do
  it("adds an album to an artist") do
    artist = Artist.new({:name => "John Coltrane", :album_name => "People", :id => nil})
    artist.save()
    album = Album.new({:name => "A Love Supreme", :id => nil, :year => 2000, :genre => "bluegrass", :artist => "old mcdonald", :status => true, :cost => 4.99})
    album.save()
    artist.update({:name => "Timer", :album_name => "A Love Supreme"})
    expect(artist.albums).to(eq([album]))
  end
end

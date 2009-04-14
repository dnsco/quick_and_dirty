#!/usr/bin/ruby
#class Alarm
#
#end

class Mixer

	def mute
		system "amixer -c 0 -- sset Master 0%"
	end

	def mix
		40.upto(82) { |i| system "amixer -c 0 -- sset Master #{i}%"; sleep(1) }	
	end

end

	
class Song

	def first
		songs = Array[ 
      '/media/archive/audio/ilovelucas/from ezra/Modeselektor/Hello Mom!/06 Ziq Zaq.mp3', 
      '/media/archive/audio/mestuff/The Arcade Fire - Funeral - Neighborhood #1 (Tunnels).mp3']
    @first = songs[rand(songs.size)]
  end

	def second
    songs = Array[] 
    @second = songs[rand(songs.size)]
	end

  #def songs
  #  @songs = Array[self.first, self.second]
  #end
end

class Player

  def play(song)
		system "mpg123 '#{song}' &"
	end

end

@mixer = Mixer.new
@player = Player.new
@song = Song.new

@mixer.mute
@player.play(@song.first)
@mixer.mix
#@player.play(@song.second)

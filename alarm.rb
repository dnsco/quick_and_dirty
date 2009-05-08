#!/usr/bin/ruby

# set $os with either mac or linux
$os = "linux"

class MixerMac
	
	def mute
		system "osascript -e 'set Volume 0'" 
	end
		
	def mix
		0.upto(10) { |i| system "osascript -e 'set Volume #{i}'"; sleep(15) }
	end	

end

class MixerLinux

	def mute
		system "amixer -c 0 -- sset Master 0%"
	end

	def mix
		42.upto(82) { |i| system "amixer -c 0 -- sset Master #{i}%"; sleep(1) }	
	end

end

	
class SongLinux

	def first
		songs = Array[ 
      '/media/archive/audio/ilovelucas/from ezra/Modeselektor/Hello Mom!/06 Ziq Zaq.mp3', 
      '/media/archive/audio/mestuff/The Arcade Fire - Funeral - Neighborhood #1 (Tunnels).mp3',
      "/home/lover/Music/BENJY/music/other\ leahy/Hide\ and\ Seek.mp3",
      "/media/archive/audio/\!\!\!\ -\ Take\ Ecstacy\ With\ Me-Get\ Up-CD\ -\ Take\ Ecstasy\ With\ Me.mp3"]
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


class SongMac

  def first
    @first = "/Users/vincenttrue/Documents/air.m3u"
  end

end


class PlayerLinux

  def play(song)
		system "mpg123 '#{song}' &"
	end

end

class PlayerMac
  
  def play(song)
    system "/Applications/VLC.app/Contents/MacOS/VLC #{song} -Z &"
  end

end

if $os == "linux"

	@mixer = MixerLinux.new
  @player = PlayerLinux.new
  @song = SongLinux.new

end

if $os == "mac"
	@mixer = MixerMac.new
  @player = PlayerMac.new
  @song = SongMac.new
end
		

@mixer.mute
@player.play(@song.first)
@mixer.mix
#@player.play(@song.second)

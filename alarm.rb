#!/usr/bin/env ruby

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

	


class Playlist

  def playlist
    @playlist = ARGV[0]
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

case $os
when "linux"
  @mixer = MixerLinux.new
  @player = PlayerLinux.new
when "mac"
  @mixer = MixerMac.new
  @player = PlayerMac.new
end
		
@playlist = Playlist.new

@mixer.mute
@player.play(@playlist)
@mixer.mix

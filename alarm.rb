#!/usr/bin/env ruby

module MixerLinux
  def mute
    system "amixer -c 0 -- sset Master 0%"
  end
  def mix _from=42, _to=85
    _from.upto(_to) { |i| system "amixer -c 0 -- sset Master #{i}%"; sleep(1) }	
  end
end

module PlayerLinux
  def play(song)
    system "mpg123 '#{song}' &"
  end
end

class Alarm 
  include MixerLinux
  include PlayerLinux

  ##include "Mixer#{self.os.upcase}".to_sym
  ##include  "Player#{self.os.upcase}".to_sym
  #include MixerLinux
  #include  PlayerLinux

  def initialize
    self.os
    eval "self.mute"
    eval "self.play(self.playlist)"
    self.mix
  end

  def playlist
    @playlist = ARGV[0] ? ARGV[0] : "playlist.m3u"
  end

  def os
    @os = case RUBY_PLATFORM
          when /linux/ then "Linux"
          when /darwin/ then "Mac"
          end
  end

end

Alarm.new
module Alarm::MixerMac
  def mute
    system "osascript -e 'set Volume 0'" 
  end
  def mix
    0.upto(10) { |i| system "osascript -e 'set Volume #{i}'"; sleep(15) }
  end	
end



module Alarm::PlayerMac
  def play(song)
    system "/Applications/VLC.app/Contents/MacOS/VLC #{song} -Z &"
  end
end


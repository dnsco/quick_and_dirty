#!/usr/bin/env ruby
module System
  def self.os
    @os ||= case RUBY_PLATFORM
            when /linux/ then "Linux"
            when /darwin/ then "Mac"
            end
  end
end

module Mixer
  module Linux
    def mute
      system "amixer -c 0 -- sset Master 0%"
    end

    def mix from=50, to=100
      from.upto(to) { |i| system "amixer -c 0 -- sset Master #{i}%"; sleep(1) }
    end
  end

  module Mac
    def mute
      system "osascript -e 'set Volume 0'"
    end

    def mix
      0.upto(10) { |i| system "osascript -e 'set Volume #{i}'"; sleep(15) }
    end
  end

  def self.load_proper_os_module
    self.const_get("#{System.os}")
  end
  include self.load_proper_os_module
end

module Player
  module Linux
    def play(song)
      system "mpg123 '#{song}' &"
    end
  end

  module Mac
    def play(song)
      system "/Applications/VLC.app/Contents/MacOS/VLC #{song} -Z &"
    end
  end

  def self.load_proper_os_module
    self.const_get("#{System.os}")
  end
  include self.load_proper_os_module
end

class Alarm
  include Mixer
  include Player

  def initialize
    mute
    play(playlist)
    mix
  end

  def playlist
    @playlist = ARGV[0] || "playlist.m3u"
  end
end

Alarm.new


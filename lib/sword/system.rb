require 'rbconfig'

module Sword
  # TODO: invert constants in way that even
  # if this class is not loaded, basic options
  # will still work
  #
  # Enables system-specific Sword features
  module System
    OLD_RUBY = RUBY_VERSION <= '1.8.7'
    WINDOWS = RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
    OCRA = ARGV.delete('ocra')
    OSX = RUBY_PLATFORM.include? 'darwin'
  end
end

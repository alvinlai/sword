module Sword
  require 'sword/system'
  require 'sword/version'
  require 'sword/debugger'
  require 'sword/environment'
  require 'sword/execute'

  def self.new(arguments = ARGV, width = 25)
    options = CLI::Parser.new(arguments, width)
    Environment::ActionSequence.new(options)
  end
end

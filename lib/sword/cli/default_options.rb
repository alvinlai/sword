module Sword
  module CLI
    class DefaultOptions < OptionList
      desc 'Permanently require the gems'
      argument Array
      parse :add do |gems|
        open(Environment.local_gems, 'a') { |f| gems.each { |g| f.puts g } }
        exit
      end

      parse :aloud, "Show server's guts"
      parse :compile, 'Compile Sword queries'

      desc 'Specify watch directory'
      default '.'
      argument :path
      parse :d => :directory
      
      desc 'Print this message'
      parse :h => :help do
        puts message
        exit
      end

      desc 'Specify host'
      default 'localhost'
      parse :host, :address

      desc 'Install must-have gems'
      parse :i => :install do
        require 'sword/installer'
        Installer.install
        exit
      end

      parse :mutex, 'Turn on the mutex lock'

      desc 'Change the port, 1111 by default'
      argument :number
      parse :p => :port

      desc 'Make PID file'
      argument :path
      parse :pid

      desc 'Skip including gems from built-in list'
      parse :plain do
        Environment.gem_lists = []
      end

      desc 'Require the gems this run'
      parse :require, Array do |gems|
        env += gems
      end

      desc 'Specify server'
      argument :name
      parse :server

      desc 'Load settings from the file'
      argument :path
      parse :settings do |path|
        instance_eval File.read(path)
      end

      parse :silent, 'Turn off any messages excluding exceptions'

      desc "Print Sword's version"
      parse :version do
        puts "Sword #{VERSION}"
        exit
      end
    end
  end
end

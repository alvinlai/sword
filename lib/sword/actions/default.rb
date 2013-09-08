module Sword
  module Actions
    class Default < Sequence
      condition System::OLD_RUBY
      action :require_rubygems do
        require 'rubygems'
      end

      action :parse_arguments do
        @parser.parse
      end

      action :load_templates do
        require 'sword/execute/lists'
        Lists.load
      end

      action :filter_templates do
        require 'sword/execute/filter'
        Filter.filter
      end

      action :load_gems do
        require 'sword/execute/loader'
        Loader.load
      end

      condition daemonize
      action :daemonize do
        Process.daemon(true)
      end

      condition !here
      action :change_directory do
        Dir.chdir directory
      end

      condition !console
      action :open_browser do
        Thread.new do
          sleep 0.75
          url = "http://localhost:#{port}"
          if System::OSX
            system "open #{url}"
          else
            require 'launchy'
            Launchy.open(url) {}
          end
        end
      end

      action :run_server do
        require 'sword/server'
        Server::Application.inject
        Server::Application.run!
      end

      condition pid
      action :delete_pid do
        File.delete(pid)
      end
    end
  end
end

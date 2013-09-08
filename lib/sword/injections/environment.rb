module Sword
  module Injections
    class Environment < Injection
      inject :pidfile do
        open(Environment.pid, 'w') { |f| f.puts Process.pid } if Environment.pid
      end

      inject :environment do
        set :show_exceptions, false unless Environment.exceptions
        set :port, Environment.port
        set :server, Environment.server if Environment.server
        set :bind, Environment.host if Environment.host
        set :lock, true if Environment.mutex
        set :views, Environment.directory # Structure-agnostic
        set :public_folder, settings.views
      end
    end
  end
end

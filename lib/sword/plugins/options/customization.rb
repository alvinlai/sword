module Sword
  module Plugins
    module Options
      class Customization < Sword::Options::List
        separator "Customization options:\n"

        parse :exceptions, 'Show default Sinatra exception page'

        desc 'Specify favicon'
        parse :favicon do |path|
          Environment.favicon = path
        end

        desc 'Specify error page'
        parse :error do |path|
          Environment.error = path
        end
      end
    end
  end
end

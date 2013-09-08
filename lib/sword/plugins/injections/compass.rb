module Sword
  module Plugins
    module Injections
      class Compass < Sword::Injections::Injection
        inject :compass do
          return unless defined? Compass
          Compass.configuration do |c|
            c.output_style = Environment.compress ? :compressed : :nested
            c.line_comments = false
            c.relative_assets = true
            c.cache = Environment.cache? ? true : false
            c.sass_dir = '.'
            c.images_dir = c.sass_dir
            c.http_images_path = c.sass_dir
            c.http_path = '/'
            c.http_stylesheets_path = c.http_path
          end

          set :sass, Compass.sass_engine_options
          set :scss, Compass.sass_engine_options
        end
      end
    end
  end
end

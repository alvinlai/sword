class Pony < Sinatra::Base  
  settings.scripts = 'scripts'
  settings.styles = 'styles'
  settings.views = 'templates'
  settings.public_folder = 'other'
  set :port, 2010

  get '/*.css' do
    content_type 'text/css', :charset => 'utf-8'
    css = params[:splat].first
    # If there is a CSS, take it.
    # Otherwise, use SASS.
    style = "#{settings.styles}/#{css}.css"
    return File.read style if File.exists? style
    sass :"#{css}", Compass.sass_engine_options
      .merge(views: settings.styles, style: :compressed)
  end

  get '/*.js' do
    content_type 'application/x-javascript', :charset => 'utf-8'
    js = params[:splat].first
    # If there is a JS, take it.
    # Otherwise, use CoffeeScript.
    script = "#{settings.scripts}/#{js}.js"
    return File.read script if File.exists? script
    coffee :"#{js}", views: settings.scripts
  end

  get '/' do
    slim :index
  end

  # Slim & HTML
  get '/*/?' do |page|
    html = "#{settings.views}/#{page}.html"
    # Make HTML in `templates` folder possible.
    return File.read(html) if File.exists?(html)
    slim page.to_sym
  end
end

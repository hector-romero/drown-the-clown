require 'bundler'

Bundler.require :default, :app, :assets

class App < Sinatra::Base
  set :assets, Sprockets::Environment.new(root)
  set :digest_assets,   false
  set :version, '0.3.0'
  set :protection,          :except => [:json_csrf]
  set :recompile_views,     settings.development?
  set :assets_prefix,       'assets'
  set :js_path,             'assets/js'
  set :css_path,            'assets/css'
  set :resources_path,      'assets/res'

  set :main_js,         'drown.js'
  set :main_css,        'drown.css'
  set :index,           :index
  set :use_key,         :debug

  def self.reconfigure(options = {})
    options = {:debug_assets => development?}.merge(options)
    configure do
      # Setup Sprockets
      puts 'Configuring'
      assets.append_path css_path
      assets.append_path js_path
      assets.append_path resources_path
      Rack::Mime::MIME_TYPES['.ttf'] = 'application/x-font-ttf'
      if  development?
        register Sinatra::Reloader
      else
        Bundler.require :compressors
        assets.js_compressor = Uglifier.new
        options = Sass::Engine::DEFAULT_OPTIONS.merge(:style => :compressed)
        Sass::Engine.send(:remove_const, :DEFAULT_OPTIONS)
        Sass::Engine.const_set(:DEFAULT_OPTIONS, options)
      end
      #Configure Sprockets::Helpers (if necessary)
      Sprockets::Helpers.configure do |config|
        config.environment = assets
        config.prefix      = assets_prefix
        config.digest      = digest_assets
        config.public_path = public_folder
        # Debug mode automatically sets
        # expand = true, digest = false, manifest = false
        config.debug      = options[:debug_assets]
      end
    end
  end
  reconfigure

  helpers do
    include Sprockets::Helpers
    def changelog
      markdown_text = File.new(settings.root + '/changelog.md').read
      markdown markdown_text
    end
    set :compiled_index, nil

    def prod_environment
      if use_debug_key?
        return false
      else
        return true
      end
    end

    def service_url
      'drown_clown/'
    end

    def index
      if !settings.compiled_index or settings.recompile_views?
        settings.compiled_index = erb(settings.index)
      end
      settings.compiled_index
    end

    def main_js
      settings.main_js
      #"main?r=#{rand}"
    end

    def main_css
      settings.main_css
      #"main?r=#{rand}"
    end

    def use_debug_key?
      if defined? settings.use_key
        return settings.use_key == :debug
      elsif development?
        return true
      else
        return false
      end
    end

    def get_version
      settings.version
    end

    def htaccess
      erb :htaccess
    end

    def service
      erb :'service.php'
    end

    def get_assets
      assets_list = []
      [main_js,main_css].each do |asset|
        assets = settings.assets.find_asset(asset)
        if settings.development?
          assets_list.concat assets.to_a
        else
          assets_list.push assets
        end
      end
      assets_list
    end
  end

  get '/' do
    index
  end
  ##############################################
  get '/readme' do
    markdown_text = File.new(settings.root + '/README.md').read
    markdown markdown_text
  end

  get '/changelog' do
    changelog
  end

  get '/drown_clown/:clown', :provides => :json do
    clown = params[:clown]
    if clown == "2"
      settings.assets.find_asset 'winner.json'
    else
      settings.assets.find_asset 'loser.json'
    end


  end

end

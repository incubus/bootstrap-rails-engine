module BootstrapRailsEngine
  module ActionViewExtensions
    OFFLINE = (::Rails.env.development? or ::Rails.env.test?)

    CDNS = {
      :bootstrap_js => {
        :default => "//netdna.bootstrapcdn.com/twitter-bootstrap/2.1.0/js/bootstrap.min.js"
      },
      :bootstrap_css => {
        :default => "//netdna.bootstrapcdn.com/twitter-bootstrap/2.1.0/css/bootstrap.min.css"
      },
    }

    def bootstrap_javascript_url(name, options = {})
      return CDNS[:bootstrap_js][name]
    end

    def bootstrap_stylesheet_url(name, options = {})
      return CDNS[:bootstrap_css][name]
    end

    # to be used with bootstrap-rails-engine gem
    def bootstrap_javascript_include_tag(name, options = {})
      if OFFLINE and !options[:force]
        return javascript_include_tag('bootstrap/bootstrap')
      else
        # Bootstrap do not offer way to check existing
        [ javascript_include_tag(bootstrap_javascript_url(name, options)),
        ].join("\n").html_safe
      end
    end
    
    def bootstrap_stylesheet_include_tag(name, options = {})
      if OFFLINE and !options[:force]
        return stylesheet_link_tag('bootstrap/bootstrap')
      else
        # Bootstrap do not offer way to check existing
        [ stylesheet_link_tag(bootstrap_stylesheet_url(name, options)),
        ].join("\n").html_safe
      end
    end
  end


   class Engine < ::Rails::Engine

    initializer 'bootstrap-rails-engine.action_view' do |app|
      ActiveSupport.on_load(:action_view) do
        include BootstrapRailsEngine::ActionViewExtensions
      end
    end
  end
end


module BootstrapRailsEngine
  module ActionViewExtensions
    BOOTSTRAP_VERSION = "3.1.1"
    FONTAWESOME_VERSION = "4.0.3"
    OFFLINE = (::Rails.env.development? or ::Rails.env.test?)

    CDNS = {
      :bootstrap_js => {
        :default => "//netdna.bootstrapcdn.com/bootstrap/#{BOOTSTRAP_VERSION}/js/bootstrap.min.js"
      },
      :bootstrap_css => {
        :default => "//netdna.bootstrapcdn.com/bootstrap/#{BOOTSTRAP_VERSION}/css/bootstrap.min.css"
      },
      :bootstrap_theme_css => {
        :default => "//netdna.bootstrapcdn.com/bootstrap/#{BOOTSTRAP_VERSION}/css/bootstrap-theme.min.css"
      },
      :fontawesome_css => {
        :default => "//netdna.bootstrapcdn.com/font-awesome/#{FONTAWESOME_VERSION}/css/font-awesome.min.css"
      }
    }

    def bootstrap_javascript_url(name)
      return CDNS[:bootstrap_js][name]
    end

    def bootstrap_stylesheet_url(name)
      return CDNS[:bootstrap_css][name]
    end

    def bootstrap_theme_stylesheet_url(name)
      return CDNS[:bootstrap_theme_css][name]
    end

    def fontawesome_stylesheet_url(name)
      return CDNS[:fontawesome_css][name]
    end

    # to be used with bootstrap-rails-engine gem
    def bootstrap_javascript_include_tag(name, options = {})
      options.reverse_merge! :local_copy => false

      bootstrap_j = 'bootstrap/bootstrap'
      bootstrap_j = bootstrap_j + '.min' if options.delete(:compressed)

      if OFFLINE and !options.delete(:force)
        options.delete(:local_copy) # not used in OFFLINE mode
        return javascript_include_tag(bootstrap_j, options)
      else
        local_copy = options.delete(:local_copy)
        j = [ javascript_include_tag(bootstrap_javascript_url(name), options) ]
        if local_copy
          j << javascript_tag("typeof $().carousel == 'function' || document.write(unescape('#{javascript_include_tag(bootstrap_j, options).gsub('<','%3C')}'))")
        end
        j.join("\n").html_safe
      end
    end

    def bootstrap_stylesheet_include_tag(name, options = {})
      bootstrap_c = 'bootstrap/bootstrap'
      bootstrap_c = bootstrap_c + '.min' if options.delete(:compressed)

      if OFFLINE and !options.delete(:force)
        return stylesheet_link_tag(bootstrap_c, options)
      else
        # Bootstrap do not offer way to check existing
        [ stylesheet_link_tag(bootstrap_stylesheet_url(name), options),
        ].join("\n").html_safe
      end
    end

    def bootstrap_theme_stylesheet_include_tag(name, options = {})
      bootstrap_t = 'bootstrap/bootstrap-theme'
      bootstrap_t = bootstrap_t + '.min' if options.delete(:compressed)

      if OFFLINE and !options.delete(:force)
        return stylesheet_link_tag(bootstrap_t, options)
      else
        # Bootstrap Theme do not offer way to check existing
        [ stylesheet_link_tag(bootstrap_theme_stylesheet_url(name), options),
        ].join("\n").html_safe
      end
    end

    def fontawesome_stylesheet_include_tag(name, options = {})
      if OFFLINE and !options.delete(:force)
        # To be used with font-awesome-rails gem.
        return stylesheet_link_tag('font-awesome', options)
      else
        # Fontawesome do not offer way to check existing
        [ stylesheet_link_tag(fontawesome_stylesheet_url(name), options),
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


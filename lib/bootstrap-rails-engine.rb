module BootstrapRailsEngine
  module ActionViewExtensions
    OFFLINE = (::Rails.env.development? or ::Rails.env.test?)

    CDNS = {
      :bootstrap_js => {
        :default => "//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"
      },
      :bootstrap_css => {
        :default => "//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css"
      },
    }

    def bootstrap_javascript_url(name)
      return CDNS[:bootstrap_js][name]
    end

    def bootstrap_stylesheet_url(name)
      return CDNS[:bootstrap_css][name]
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
        j = [ javascript_include_tag(bootstrap_javascript_url(name), options) ]
        if options.delete(:local_copy)
          j << javascript_tag("typeof $().carousel == 'function' || document.write(unescape('#{javascript_include_tag(bootstrap_j, options).gsub('<','%3C')}'))")
        end
        j.join("\n").html_safe
      end
    end

    def bootstrap_stylesheet_include_tag(name, options = {})
      if OFFLINE and !options.delete(:force)
        return stylesheet_link_tag('bootstrap/bootstrap', options)
      else
        # Bootstrap do not offer way to check existing
        [ stylesheet_link_tag(bootstrap_stylesheet_url(name), options),
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


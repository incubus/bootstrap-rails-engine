module BootstrapRailsEngine
  module Rails
    if ::Rails.version < "3.1"
      require "bootstrap-rails-engine/railtie"
    else
      require "bootstrap-rails-engine/engine"
    end
  end
end


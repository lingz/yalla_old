# Load the rails application
require File.expand_path('../application', __FILE__)

config.assets.precompile += %w( jquery.js )
config.assets.precompile += %w( jquery.masonry.min.js )
config.assets.precompile += %w( jquery-ui-1.10.2.custom.js )
config.assets.precompile += %w( base.js )
config.assets.precompile += %w( bootstrap.js )

# Initialize the rails application
Unilink::Application.initialize!

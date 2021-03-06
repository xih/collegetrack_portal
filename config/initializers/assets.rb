# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.1'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( google_auth.js )
Rails.application.config.assets.precompile += %w( email.css )
Rails.application.config.assets.precompile += %w( filter.js )
Rails.application.config.assets.precompile += %w( email.js )
Rails.application.config.assets.precompile += %w( header.css )
Rails.application.config.assets.precompile += %w( header.js )
Rails.application.config.assets.precompile += %w( admin.css )
Rails.application.config.assets.precompile += %w( admin.js )
Rails.application.config.assets.precompile += %w( reset_sf.css )
Rails.application.config.assets.precompile += %w( groups.css )
Rails.application.config.assets.precompile += %w( groups.js )

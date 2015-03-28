# Set directories
set :partials_dir, 'partials'

set :debug_assets, true

# Development-specific configuration
configure :development do
  # Reload the browser automatically whenever files change
  activate :livereload, no_swf: true

  # Deploy to S3
  activate :s3_sync do |options|
    options.bucket = 'lydh'
  end
end

# Setup Cloudfront for invalidations
activate :cloudfront do |options|
  options.access_key_id = ENV['AWS_ACCESS_KEY_ID']
  options.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  options.distribution_id = 'E2OA20CLV7SC3S'
  options.filter = /\.html$/i
end

# Build-specific configuration
configure :build do
  # Minify source
  activate :minify_css
  activate :minify_html

  # Set asset host
  # Bug - https://github.com/middleman/middleman-sprockets/issues/46
  # activate :asset_host, host: 'http://assets.learnyourdamnhomophones.com'

  # Enable cache buster
  activate :asset_hash

  # Use GZIP compression
  activate :gzip
end
source 'https://rubygems.org'

gem 'rails', '~> 4.2.7'

gem 'sprockets'
gem 'sprockets-es6', require: 'sprockets/es6'

gem 'responders' # See https://github.com/plataformatec/responders

gem 'turbolinks', '~> 2.5'
gem 'jquery-turbolinks'

gem 'rails-i18n'

# kaminair must be before elasticsearch to work with es
gem 'kaminari'

gem 'elasticsearch-rails'
gem 'elasticsearch-model'
gem 'elasticsearch-dsl'

# Nice progressbar to use in rake tasks
gem 'ruby-progressbar', require: false

gem 'mysql2'

gem 'jbuilder', '~> 2.0'

gem 'haml', '~> 4.0.0'
gem 'haml-rails'

# gem 'bcrypt', '~> 3.1.7'

gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'jquery.fileupload-rails'

gem 'font-awesome-sass', '~> 4.3'
gem 'bootstrap-sass', '~> 3.3'
gem 'sass-rails', '~> 5.0'
gem 'autoprefixer-rails'
gem 'modernizr-rails', '~> 2.7.1'

gem 'mini_magick'

gem 'fog-rackspace'
gem 'refile', require: 'refile/rails'
gem 'refile-mini_magick'
gem 'leifcr-refile-fog'

gem 'paperclip'
# gem 'paperclip-optimizer', '~> 2.0.0'
# gem 'image_optim', '~> 0.20'
# gem 'image_optim_pack'
gem 'delayed_paperclip'

gem 'interactor-rails', '~> 2.0'

# For CC payments using checkout.js
gem 'stripe'

# For sending public stripe token to js from secrets.yml
gem 'gon'

# For states: https://github.com/gocardless/statesman
gem 'statesman'

# For unique id's on orders, carts etc, since integers can be easily found
gem 'activeuuid'

# CSP setup/reporting
gem 'secure_headers'

# Asset precompilation
# Can be removed if webpack is used instead
gem 'uglifier', '>= 1.3.0'
gem 'execjs' # uglifier requirement
# Use nodejs/iojs in prod env
# Use therubyracer in development/test
# gem 'mini_racer'
gem 'therubyracer' # , group: [:development] # execjs/uglifier requirement

# Error Tracking
gem 'sentry-raven'

# Profiler
gem 'skylight', group: [:staging, :production]

# Use puma as the web server
gem 'puma'

gem 'delayed_job'
gem 'delayed_job_active_record'

# Forms
gem 'simple_form', '~> 3.2.0'
gem 'country_select'
gem 'countries'

# Authentication
gem 'devise'
gem 'devise-i18n'

gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-linkedin-oauth2'

# Authorization
gem 'pundit'

group :development, :test do
  gem 'rspec-rails', '~> 3.5' # , group: [:development, :test]
  # gem 'rspec-collection_matchers'
  gem 'faker'
end

group :test do
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'factory_girl_rails', require: false # , group: [:test]
  gem 'shoulda-matchers'
  gem 'timecop'

  # Retry if phantomjs just blows up...
  # gem 'rspec-retry'

  # js drivers for capybara
  # Use phantomjs through poltergeist
  gem 'poltergeist'
  # Alternative: change to https://github.com/elgalu/docker-selenium
  # For using real chrome/ff browsers through selenium

  # Coverage
  # gem 'simplecov', require: false
  # gem 'simplecov-rcov', require: false

  # Notificiations sent to growl through gntp
  gem 'ruby_gntp'
end

gem 'awesome_nested_set'

# Ordering various models

gem 'ranked-model'

# NOTE: slugs from friendly_id should be saved in history with paper_trail
gem 'friendly_id'

gem 'momentjs-rails'

gem 'hashie' # used by content on json data
# Alternative: use virtus models instead of hashie serialized cols
# gem 'virtus'

# For inlining css on emails (gmail + others remove css styles...)
gem 'premailer-rails'

gem 'terminal-table'

# For truncating/word_wrapping tables. (Facets has a lot of ruby extension goodies...)
gem 'facets', require: false

# For validating email addresses
gem 'valid_email2'

# Edtior alternatives
# gem 'medium-editor-rails'
# Redactor editor (tested, not good results, but OK)
# Froala editor should be ok...?
# Keep at 2.0.2 until tested with 2.2
gem 'wysiwyg-rails' # , '2.0.2'
gem 'codemirror-rails'

# For publish/draft/versining, paper_trail is used
gem 'paper_trail', '~> 4.1'

# Prettier alerts
# TODO: Change to this to include confirm method for rails.confirm ujs
gem 'sweet-alert-confirm'

source 'https://rails-assets.org' do
  gem 'rails-assets-slick-carousel'
  gem 'rails-assets-jquery', '~> 2.2.4', require: false
  gem 'rails-assets-sweetalert'
  gem 'rails-assets-accounting.js'
  gem 'rails-assets-animate.css'
  gem 'rails-assets-select2'
  gem 'rails-assets-select2-bootstrap-theme'
  gem 'rails-assets-pnotify'
  gem 'rails-assets-typeahead.js'
  gem 'rails-assets-jquery.lazyload'
end

# Better lightboxes
# For galleries, use magnific-popup in combination with slick slider
# For single images, videos, logins etc, use magnific-popup
gem 'magnific-popup-rails'

# Clipboard if needed
gem 'clipboard-rails'

# Caching in memcached through dalli
gem 'dalli'

# Connection pooling for dalli/puma, when running multi threaded:
# See https://github.com/petergoldstein/dalli#multithreading-and-rails
gem 'connection_pool'

# Use Faraday for requests?
gem 'faraday' # do http requests over tons of adapters...
gem 'excon'   # for using excon faraday adapter

gem 'enumerize'

# For prettier pagination in urls
gem 'routing-filter'

# For truncating html
gem 'truncate_html'

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'

  #  gem 'rails-dev-tweaks', '~> 0.5.1'

  # Use Capistrano for deployment
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-monit_runit', require: false
  gem 'capistrano-pumaio', require: false
  gem 'capistrano-delayed_job', require: false
  gem 'capistrano-db-tasks', require: false, git: 'https://github.com/leifcr/capistrano-db-tasks.git', tag: 'v0.4.1'

  gem 'binding_of_caller'
  gem 'better_errors'

  gem 'quiet_assets'

  gem 'nokogiri' # Needed for data-import.
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # For reloading during devel
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
  gem 'guard-rspec', require: false

  # Cannot use guard-bundler on Windows, because of symlink issue.
  # gem 'guard-bundler', require: false
  # Cannot use guard-foreman on Windows, because of symlink issue.
  # gem 'guard-foreman', require: false
  # gem 'foreman', require: false

  # Annotate all the models :)
  gem 'annotate', require: false

  # Allow mailer_preview to have access to params
  # gem 'mailer_preview_request_model'

  # Better ruby/rails console
  gem 'pry-rails'
  gem 'pry-toys'
end

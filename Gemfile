source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.4'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'pry-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Added bootstrap-sass
gem 'bootstrap-sass', '~> 3.3.6'
# On a déja sass-rail 5.0 dans le Gemfile donc on comment la ligne suivant
#gem 'sass-rails', '>= 3.2'

# On va ajouter le gem devise to gerer l'autentication des utilisateurs
gem 'devise', '~> 4.2'

# On va ajouter le gem toastr-rails pour manager les notifications
gem 'toastr-rails', '~> 1.0'

# On va rajouter 2 gems pour manager les notifications
# omniauth et omniauth-facebook

gem 'omniauth', '~> 1.6'
gem 'omniauth-facebook', '~> 4.0'

# Gem pour gerer les attachements de fichier comme image etc
gem 'paperclip', '~> 5.1.0'

# Gem pour gerer le cloud d'amazon web services 
gem 'aws-sdk', '~> 2.8'

# Add the geocoder gem
gem 'geocoder', '~> 1.4'

gem 'jquery-ui-rails', '~> 5.0'

# rajouter un timepicker pour selectioner l'heure des prestations
gem 'jquery-timepicker-rails', '~> 1.11', '>= 1.11.10'

# Gem pour gerer la recherche  des menus 

gem 'ransack',  '~> 1.7'

#------ Kinywa 3 ---------
gem 'twilio-ruby', '~> 4.11.1'
#gem 'twilio-ruby', '~> 5.2.3'

gem 'fullcalendar-rails', '~> 3.4.0'
gem 'momentjs-rails', '~> 2.17.1'

gem 'stripe', '~> 3.0.0'
gem 'rails-assets-card', source: 'https://rails-assets.org'
gem 'omniauth-stripe-connect', '~> 2.10.0'

gem 'chartkick', '~> 2.2.4'
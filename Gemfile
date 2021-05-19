source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

# =========================================
# Please add new Gems in alphabetical order
# =========================================

#
# Rails and Databases
#

gem 'rails', '~> 5.2.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'redis', '~> 4.0'

#
# System Gems
#

gem 'bootsnap', '>= 1.1.0', require: false
gem 'dalli'
gem 'jbuilder'
gem 'kaminari'
gem 'puma', '~> 4.3'
gem 'rack-cors'

#
# Development / Testing
#

group :development, :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

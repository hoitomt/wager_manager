source 'https://rubygems.org'

ruby '2.6.6'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2'
gem 'pg', '~> 1.1.0'
gem 'puma', '~> 4.3.8'
gem 'sass-rails', '~> 6.0.0'
gem 'uglifier', '>= 4.2.0'
gem 'webpacker'
gem 'turbolinks', '~> 5.2.1'
gem 'jbuilder', '~> 2.9.1'
gem 'jquery-rails'
gem 'popper_js', '~> 1.14.5'
gem 'bootstrap', '~> 4.3.1'
gem 'devise'
gem 'simple_form'
gem 'figaro'
gem 'sprockets', '~> 3.7'
gem 'attr_encrypted', '~> 3.1'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.9'
  gem 'factory_bot_rails', '~> 4.8.2'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


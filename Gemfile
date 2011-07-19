source :gemcutter

gem 'rails', '~> 2.3.11'
gem "rack", "1.1.1"

gem 'rubytree', "0.5.2", :require => "tree"
gem 'coderay', '~>0.9.7'
# freezed mysql2 at 0.2.7 because further versions have Rails 2.3.11 compatibility problems
gem 'mysql2', '=0.2.7'
gem 'nokogiri'

group :development do
  gem 'capistrano'
end

group :test do
  gem "shoulda"
  gem "mocha", :require => nil # ":require => nil" fixes obscure bugs - remote and run all tests
  gem "edavis10-object_daddy", :require => "object_daddy"
end

# Load plugins' Gemfiles
Dir.glob(File.join(File.dirname(__FILE__), %w(vendor plugins * Gemfile))) do |file|
  puts "Loading #{file} ..."
  instance_eval File.read(file)
end

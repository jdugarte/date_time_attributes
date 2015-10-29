$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "date_time_attributes/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "date_time_attributes"
  s.version     = DateTimeAttributes::VERSION
  s.author      = "Jesús Dugarte"
  s.email       = "jdugarte@gmail.com"
  s.homepage    = "http://github.com/jdugarte/date_time_attributes/"
  s.summary     = "Creates date and time virtual attributes from a date/time attribute"
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency 'rails'
  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'timecop'
end

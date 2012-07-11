$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ecm/downloads/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ecm_downloads"
  s.version     = Ecm::Downloads::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.homepage    = "https://github.com/robotex82/ecm_downloads"
  s.summary     = "Provides downloads for active admin."
  s.description = "Provides downloads for active admin."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.6"

  # Development database
  s.add_development_dependency "sqlite3"
  
  # Development server
  s.add_development_dependency "thin"
  
  # Documentation
  s.add_development_dependency "yard"
  
  # Testing
  s.add_development_dependency "rspec-rails", "~> 2.0"
  s.add_development_dependency "factory_girl_rails", "~> 3.0"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "capybara"
  
  # Dummy App
  # s.add_development_dependency "activeadmin" # Using edge active admin (see Gemfile)
  s.add_development_dependency "sass-rails"
  s.add_development_dependency "meta_search", ">= 1.1.0.pre"
  s.add_development_dependency "coffee-rails"
end

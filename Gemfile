source 'https://rubygems.org'

# Specify your gem's dependencies in test.gemspec
gemspec

# If the .gemspec in each of these git repos doesn't match the version
# required by THIS gem's .gemspec, bundler will print an error.

# FIXME: Remove ktcommon if not needed:
#gem 'ktcommon', :git => 'ssh://git@bitbucket.org/ktechsystems/ktcommon.git'
gem 'ktutils', :git => 'git@github.com:jmcaffee/ktutils.git'

group :test do
  gem 'fakefs', require: "fakefs/safe"
end


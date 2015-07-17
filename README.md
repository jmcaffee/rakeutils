# RakeUtils

A Ruby gem providing helper tasks for calling external applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rakeutils'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rakeutils

## Usage

Within your `rakefile`, require the tasks you'd like to use:

```ruby
require "rakeutils" # Require ALL RakeUtils tasks OR

# Require individual tasks as needed
require "rakeutils/filegentask"
require "rakeutils/innotask"
require "rakeutils/javacctask"
require "rakeutils/jjtreetask"
require "rakeutils/ocratask"
require "rakeutils/tex2rtf"
require "rakeutils/versioninc"
require "rakeutils/ziptask"
```

## TODOs

This gem was created quite a while ago and I used java naming conventions when
it was written.

- TODO: Refactor all remaining identifiers to ruby naming conventions.


## Bugs/Questions/Get Help

Create an issue at [https://github.com/jmcaffee/rakeutils/issues](https://github.com/jmcaffee/rakeutils/issues).

## Testing

From the root project dir, run:

    $ rspec spec/

## Contributing

1. Fork it ( https://github.com/jmcaffee/rakeutils/fork )
2. Clone it (`git clone git@github.com:[my-github-username]/rakeutils.git`)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Create your tests
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create a new Pull Request


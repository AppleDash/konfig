# Konfig

Stupid simple configuration file loader for Ruby, intended to be used with large Rails apps that have a lot of configuration.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'konfig'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install konfig

## Usage
Extend `Konfig::Config` and make an instance of it:

```ruby
require 'konfig'

class CustomConfig < Konfig::Config
  SECTIONS = [:foo, :bar]
  
  attr_accessor *SECTIONS # Important!
  
  def initialize
    super(Rails.root.join('config', 'custom'), SECTIONS)
  end
end

config = CustomConfig.new
```

This will require the files `foo.yml` and `bar.yml` to be present in `<rails root>/config/custom/`, and make their contents available as
Ruby objects at config.foo and config.bar.

You can also make a sub-directory of the config directory named `local`, and any files in there with the same name as a file in the base config directory will have their contents merged with the base config. This is useful for changing settings across different environments in a Rails app.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

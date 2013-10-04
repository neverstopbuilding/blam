# BLAM! [![Build Status](https://travis-ci.org/neverstopbuilding/blam.png?branch=develop)](https://travis-ci.org/neverstopbuilding/blam)

##Create ruby files quickly on the command line. BLAM!

It's a pain to have to create a bunch of folders and duplicate files to make your source and associated test files. Blam fixes this.

## Installation

Add this line to your application's Gemfile:

    gem 'blam'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install blam

## Usage

    $ blam BeastlyModule::DopeClass
    
By default creates these files:

    - lib
        - beastly_module
            - dope_class.rb
    - spec
        - beastly_module
            - dope_class_spec.rb
            
The class file has:

```ruby
# Encoding: utf-8

module BeastlyModule
  class DopeClass

  end
end
```

The spec file has: 

```ruby
# Encoding: utf-8

require 'spec_helper'
require 'beastly_module/dope_class'

describe BeastlyModule::DopeClass do

end
```

###Command Line Options

- **--source-dir** - Pass an alternative directory to `lib` in which the source files will be created.
- **--tests-dir** - Pass an alternative directory to `spec` in which the test files will be created.
- **--test-suffix** - Change the suffix from the test files from the default `spec` to anything you like. Non spec suffixes will get a default class template rather than an rspec class template. 
- **--additional-test-dirs** - Add other directories to create additional test files. This can be helpful for breaking up your tests into folders like `spec/unit` `spec/integration`

###.blam File

No one likes to type all those crazy options all the time! BLAM! Put them in a file called `.blam` in the root of your project:

```YAML
tests_dir: spec/unit/lib
additional_test_dirs: [spec/integration/lib, spec/system/lib]
source_dir: lib
test_suffix: spec
```

Don't worry, you can override these with the command line options any time. Blam!

## Contributing

1. Fork it
2. Create your feature branch with [git-flow](https://github.com/nvie/gitflow) (`git flow feature start my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Run the fucking tests (`rake` Runs Rubocop and Cucumber by default.)
4. Publish the feature (`git flow feature publish my-new-feature`)
5. Create new Pull Request

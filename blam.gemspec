# Encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'blam'
  spec.version       = '1.1.0'
  spec.authors       = ['Jason Fox']
  spec.email         = ['jasonrobertfox@gmail.com']
  spec.description   = %q{Blam: quickly create ruby source and test files in the right place.}
  spec.summary       = %q{With a single command Blam will create your source file and any test files in the right directories based on namespace.}
  spec.homepage      = 'https://github.com/neverstopbuilding/blam'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'aruba'
  spec.add_development_dependency 'rubocop'
  spec.add_dependency 'thor'
end

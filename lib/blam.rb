# Encoding: utf-8

require 'blam/version'
require 'thor'

class Blam < Thor::Group
  include Thor::Actions

  argument :name

  def self.source_root
    File.dirname(__FILE__)
  end

  def create_source_file
    template('templates/source.tt', "lib/#{name}.rb")
  end

  def create_test_file
    template('templates/rspec.tt', "spec/#{name}_spec.rb")
  end
end

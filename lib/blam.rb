# Encoding: utf-8

require 'thor/group'

class Blam < Thor::Group
  VERSION = "0.0.1"

  include Thor::Actions

  argument :name

  class_option :source_dir, default: 'lib'
  class_option :tests_dir, default: 'spec'
  class_option :test_suffix, default: 'spec'
  class_option :additional_test_dirs, type: :array

  def self.source_root
    File.dirname(__FILE__)
  end

  def create_source_file
    dir = options[:source_dir]
    template('templates/source.tt', "#{dir}/#{get_path(name)}.rb")
  end

  def create_test_file
    dirs = [options[:tests_dir]]
    test_suffix = options[:test_suffix]
    test_template = test_suffix == 'rspec' ? 'rspec' : 'test'
    dirs.concat options[:additional_test_dirs] if options[:additional_test_dirs]
    dirs.each do |dir|
      template("templates/#{test_template}.tt", "#{dir}/#{get_path(name)}_#{test_suffix}.rb")
    end
  end

  private

    def get_path(name)
      name.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').gsub(/([a-z\d])([A-Z])/, '\1_\2').tr('-', '_').downcase
    end
end

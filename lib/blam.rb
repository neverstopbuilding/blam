# Encoding: utf-8

require 'thor/group'
require 'yaml'

class Blam < Thor::Group
  include Thor::Actions

  argument :name

  class_option :source_dir
  class_option :tests_dir
  class_option :test_suffix
  class_option :additional_test_dirs, type: :array
  class_option :no_tests, type: :boolean
  class_option :just_unit, type: :boolean

  def self.source_root
    File.dirname(__FILE__)
  end

  def init
    if name == '--init'
      file_name = '.blam'
      template('templates/blam.tt', file_name) unless File.exists?(file_name)
      exit(0)
    end
  end

  def create_source_file
    dir = opts[:source_dir]
    @class_parts = name.split('::')
    file_name = "#{dir}/#{get_path(name)}.rb"
    if @class_parts.count == 1
      template('templates/module.tt', file_name) unless File.exists?(file_name)
    else
      template('templates/source.tt', file_name) unless File.exists?(file_name)
    end
  end

  def create_test_file
    if opts[:no_tests]
      puts 'Skipped the tests, you lazy piece of shit!'
    else
      dirs = [opts[:tests_dir]]
      test_suffix = opts[:test_suffix]
      test_template = test_suffix == 'spec' ? 'rspec' : 'test'
      dirs.concat opts[:additional_test_dirs] if opts[:additional_test_dirs] && !opts[:just_unit]
      dirs.each do |dir|
        @name = name
        @path = get_path(name)
        file_name = "#{dir}/#{get_path(name)}_#{test_suffix}.rb"
        template("templates/#{test_template}.tt", file_name) unless File.exists?(file_name)
      end
    end
  end

  private

  def get_path(name)
    name.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').gsub(/([a-z\d])([A-Z])/, '\1_\2').tr('-', '_').downcase
  end

  def opts
    default_opts = { source_dir: 'lib', tests_dir: 'spec', test_suffix: 'spec' }
    cli_opts = symbolize(options)
    return default_opts.merge(cli_opts) unless File.exists?('.blam')
    raw_file_opts = ::YAML.load_file('.blam') || {}
    file_opts = symbolize(raw_file_opts)
    default_opts.merge(file_opts).merge(cli_opts)
  end

  def symbolize(hash)
    new_hash = {}
    hash.each do |key, value|
      new_hash[key.to_sym] = value
    end
    new_hash
  end
end

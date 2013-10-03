# Encoding: utf-8

require 'aruba/cucumber'

Before do
  FileUtils.rm_rf('build/tmp')
  @dirs = ['build/tmp']
end

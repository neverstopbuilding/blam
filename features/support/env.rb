# Encoding: utf-8

ENV['ARUBA_REPORT_DIR']='build/doc'
require 'aruba/cucumber'
Before do
  @dirs = ['build/tmp']
end

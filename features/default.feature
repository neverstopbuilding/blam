@announce
Feature: Creates a class and associated test files in the correct place

Scenario: Running the command with no arguments
Given: I run `bundle exec blam NameSpace::ClassName`
Then the following directories should exist:
      | lib/name_space |
      | spec/name_space |
    And the following files should exist:
      | lib/name_space/class_name.rb |
      | spec/name_space/class_name_spec.rb |

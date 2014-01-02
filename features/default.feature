@announce
Feature: Creates a class and associated test files in the correct place

Scenario: Running the command with no arguments
Given I run `bundle exec blam NameSpace::ClassName`
Then the following directories should exist:
      | lib/name_space  |
      | spec/name_space |
    And the following files should exist:
      | lib/name_space/class_name.rb       |
      | spec/name_space/class_name_spec.rb |

Scenario: Creating a top level module
    Given I run `bundle exec blam ModuleName`
    Then the file "lib/module_name.rb" should contain exactly:
"""
# Encoding: utf-8

module ModuleName
end

"""
    And the following files should exist:
        | spec/module_name_spec.rb |

Scenario: Specifying the source path
    Given I run `bundle exec blam NameSpace::ClassName --source_dir=other/dir`
    Then the following files should exist:
        | other/dir/name_space/class_name.rb |


Scenario: A trailing slash should not matter
    Given I run `bundle exec blam NameSpace::ClassName --source_dir=other/dir/`
    Then the following files should exist:
        | other/dir/name_space/class_name.rb |

Scenario: Specifying the test path
    Given I run `bundle exec blam NameSpace::ClassName --tests_dir=spec/unit/lib`
    Then the following files should exist:
        | spec/unit/lib/name_space/class_name_spec.rb |

Scenario: Specifying the test suffix
    Given I run `bundle exec blam NameSpace::ClassName --test_suffix=test`
    Then the following files should exist:
        | spec/name_space/class_name_test.rb |

Scenario: Specifying additional test directories
    Given I run `bundle exec blam NameSpace::ClassName --tests_dir=spec/unit/lib --additional-test-dirs=spec/integration/lib spec/system/lib`
    Then the following files should exist:
        | lib/name_space/class_name.rb                       |
        | spec/unit/lib/name_space/class_name_spec.rb        |
        | spec/integration/lib/name_space/class_name_spec.rb |
        | spec/system/lib/name_space/class_name_spec.rb      |

Scenario: Specifying default settings with a .blam file
      Given a file named ".blam" with:
        """
        tests_dir: spec/unit/lib
        additional_test_dirs: [spec/integration/lib, spec/system/lib]
        source_dir: src
        test_suffix: test
        """
        When I run `bundle exec blam NameSpace::ClassName`
        Then the following files should exist:
            | src/name_space/class_name.rb                       |
            | spec/unit/lib/name_space/class_name_test.rb        |
            | spec/integration/lib/name_space/class_name_test.rb |
            | spec/system/lib/name_space/class_name_test.rb      |

Scenario: Initializing a .blam file
    Given I run `bundle exec blam --init`
    Then the file ".blam" should contain exactly:
"""
tests_dir: spec/unit/lib
source_dir: lib
test_suffix: spec
# additional_test_dirs: [spec/integration/lib, spec/system/lib]

"""

Scenario: Overriding the .blam file with cli options
    Given a file named ".blam" with:
        """
        tests_dir: spec/unit/lib
        additional_test_dirs: [spec/integration/lib, spec/system/lib]
        source_dir: src
        test_suffix: test
        """
    When I run `bundle exec blam NameSpace::ClassName --tests_dir=tests/unit/lib --additional-test-dirs=tests/integration/lib tests/system/lib --source_dir=code --test_suffix=example `
    Then the following files should exist:
        | code/name_space/class_name.rb                       |
        | tests/unit/lib/name_space/class_name_example.rb        |
        | tests/integration/lib/name_space/class_name_example.rb |
        | tests/system/lib/name_space/class_name_example.rb      |

Scenario: Create the correct source  and test file
Given I run `bundle exec blam NameSpace::OtherSpace::ClassName`
    Then the file "lib/name_space/other_space/class_name.rb" should contain exactly:
"""
# Encoding: utf-8

module NameSpace
  module OtherSpace
    class ClassName
    end
  end
end

"""
    And the file "spec/name_space/other_space/class_name_spec.rb" should contain exactly:
"""
# Encoding: utf-8

require 'spec_helper'
require 'name_space/other_space/class_name'

describe NameSpace::OtherSpace::ClassName do
end

"""

Scenario: Create the correct alternative test file
Given I run `bundle exec blam NameSpace::OtherSpace::ClassName --test_suffix=test`
    Then the file "spec/name_space/other_space/class_name_test.rb" should contain exactly:
"""
# Encoding: utf-8

require 'name_space/other_space/class_name'

class NameSpace::OtherSpace::ClassNameTest do
end

"""

Scenario: Don't overwrite existing files
      Given a file named "lib/name_space/class_name.rb" with:
"""
Important Code
"""
        When I run `bundle exec blam NameSpace::ClassName`
        Then the file "lib/name_space/class_name.rb" should contain exactly:
"""
Important Code
"""

Scenario: Don't create test files if there is an over ride
      Given a file named ".blam" with:
        """
        tests_dir: spec/unit/lib
        additional_test_dirs: [spec/integration/lib, spec/system/lib]
        source_dir: src
        test_suffix: test
        """
        When I run `bundle exec blam --no-tests NameSpace::ClassName`
        Then the following files should exist:
            | src/name_space/class_name.rb                       |
        And the output should contain "Skipped the tests, you lazy piece of shit!"
        And the following files should not exist:
            | spec/unit/lib/name_space/class_name_test.rb        |
            | spec/integration/lib/name_space/class_name_test.rb |
            | spec/system/lib/name_space/class_name_test.rb      |

Scenario: Only create the unit tests with an over ride
      Given a file named ".blam" with:
        """
        tests_dir: spec/unit/lib
        additional_test_dirs: [spec/integration/lib, spec/system/lib]
        source_dir: src
        test_suffix: test
        """
        When I run `bundle exec blam --just-unit NameSpace::ClassName`
        Then the following files should exist:
            | src/name_space/class_name.rb                       |
            | spec/unit/lib/name_space/class_name_test.rb        |
        And the following files should not exist:
            | spec/integration/lib/name_space/class_name_test.rb |
            | spec/system/lib/name_space/class_name_test.rb      |

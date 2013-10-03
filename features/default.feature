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

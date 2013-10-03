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
    And the following files should exist:
        | other/dir/name_space/class_name.rb |

Scenario: A trailing slash should not matter
    Given I run `bundle exec blam NameSpace::ClassName --source_dir=other/dir/`
    And the following files should exist:
        | other/dir/name_space/class_name.rb |

Scenario: Specifying the test path
    Given I run `bundle exec blam NameSpace::ClassName --tests_dir=spec/unit/lib`
    And the following files should exist:
        | spec/unit/lib/name_space/class_name_spec.rb |

Scenario: Specifying the test suffix
    Given I run `bundle exec blam NameSpace::ClassName --test_suffix=test`
    And the following files should exist:
        | spec/name_space/class_name_test.rb |

Scenario: Specifying additional test directories
    Given I run `bundle exec blam NameSpace::ClassName --tests_dir=spec/unit/lib --additional-test-dirs=spec/integration/lib spec/system/lib`
    And the following files should exist:
      | lib/name_space/class_name.rb       |
      | spec/unit/lib/name_space/class_name_spec.rb |
      | spec/integration/lib/name_space/class_name_spec.rb |
      | spec/system/lib/name_space/class_name_spec.rb |



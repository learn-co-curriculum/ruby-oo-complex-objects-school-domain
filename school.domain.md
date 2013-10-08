# Domain Model for a School

Write a model that stores students along with the grade that they are in.

```ruby
school = School.new("Bayside High School")
```

If no students have been added, the roster should be empty:

```ruby
school.roster
# => {}
```

When you add a student, they get added to the correct grade.

```ruby
school.add_student("Zach Morris", 9)
school.roster
# => {9 => ["Zach Morris"]}
```

You can, of course, add several students to the same grade, and students to different grades.

```ruby
school.add_student("AC Slater", 9)
school.add_student("Kelly Kapowski", 10)
school.add_student("Screech", 11)
school.roster
# => {9 => ["Zach Morris", "AC Slater"], 10 => ["Kelly Kapowski"], 11 => ["Screech"]}
```

Also, you can ask for all the students in a single grade:

```ruby
school.grade(9)
# => ["Zach Morris", "AC Slater"]
```

Lastly, you should be able to get a sorted list of all the students. Grades are sorted in descending order numerically, and the students within them are sorted in ascending order alphabetically.

```ruby
school.sort
# => {9 => ["AC Slater", "Zach Morris"], 10 => ["Kelly Kapowski"], 11 => ["Screech"]}
```
Here's a test suite to help you validate.

*Install the fis-test gem*

```ruby
require 'fis/test'

class SchoolTest
  extend Fis::Test

  test 'an empty school should have an empty roster' do
    school = School.new("Test School")
    assert_equal school.roster, {}
  end

  test 'a school should be able to add a student' do
    school = School.new("Test School")
    school.add_student("AC Slater", 10)
    assert_equal school.roster, {10 => ["AC Slater"]}
  end

  test 'a school should be able to add multiple students to a class (grade)' do
    school = School.new("Test School")

    school.add_student("Jeff Baird", 10)
    school.add_student("Blake Johnson", 10)

    assert_equal school.roster, {10 => ["Jeff Baird", "Blake Johnson"]}
  end

  test 'a school should be able to add students to different grades' do
    school = School.new("Test School")

    school.add_student("Homer Simpson", 9)
    school.add_student("Jeff Baird", 10)
    school.add_student("Avi Flombaum", 10)
    school.add_student("Blake Johnson", 7)

    assert_equal school.roster, {9 => ["Homer Simpson"], 10 => ["Jeff Baird", "Avi Flombaum"], 7 => ["Blake Johnson"]}
  end

  test 'a school should be able to retreive students from a grade' do
    school = School.new("Test School")

    school.add_student("Homer Simpson", 9)
    school.add_student("Avi Flombaum", 10)
    school.add_student("Jeff Baird", 10)
    school.add_student("Blake Johnson", 7)

    assert_equal school.grade(10), ["Avi Flombaum", "Jeff Baird"]
  end

  test 'a school should be able to sort the students' do
    school = School.new("Test School")

    school.add_student("Homer Simpson", 9)
    school.add_student("Bart Simpson", 9)
    school.add_student("Avi Flombaum", 10)
    school.add_student("Jeff Baird", 10)
    school.add_student("Blake Johnson", 7)
    school.add_student("Jack Bauer", 7)

    assert_equal school.sort, {7 => ["Blake Johnson", "Jack Bauer"], 9 => ["Homer Simpson"], 10 => ["Avi Flombaum", "Jeff Baird"]}
  end
end
```

---
  tags: oop, tdd
  languages: ruby
---

# Domain Model for a School

In this assignment you'll be writing a simple app for a school. You're going to 
Want to get write the models below and get the test suite to pass. 

## Instructions

### Part 1. 

Write a model that stores students along with the grade that they are in so the 
following code would work:

```ruby
school = School.new("Bayside High School")
```

### Part 2. 

If no students have been added, the roster should be empty:

```ruby
school.roster
# => {}
```
### Part 3.

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

### Part 4. 

Also, you can ask for all the students in a single grade:

```ruby
school.grade(9)
# => ["Zach Morris", "AC Slater"]
```

### Part 5.
 
 You should be able to get a sorted list of all the students. Grades are sorted 
 in descending order numerically, and the students within them are sorted in 
 ascending order alphabetically.

```ruby
school.sort
# => {9 => ["AC Slater", "Zach Morris"], 10 => ["Kelly Kapowski"], 11 => ["Screech"]}
```
Here's a test suite to help you validate.

```ruby
require 'rspec'

describe School do
  before :each do
    @school = School.new("Test School")
  end

  describe "::new" do
    it 'should have an empty roster when initialized' do
      @school.roster.length.should eq(0)
    end
  end

  describe "#add_student" do
    it 'should be able to add a student' do
      @school.add_student("AC Slater", 10)
      @school.roster.should eq({10 => ["AC Slater"]})
    end

    it 'be able to add multiple students to a class (grade)' do
      @school.add_student("Jeff Baird", 10)
      @school.add_student("Blake Johnson", 10)

      @school.roster.should eq({10 => ["Jeff Baird", "Blake Johnson"]})
    end

    it 'should be able to add students to different grades' do
      @school.add_student("Homer Simpson", 9)
      @school.add_student("Jeff Baird", 10)
      @school.add_student("Avi Flombaum", 10)
      @school.add_student("Blake Johnson", 7)

      @school.roster.should eq({9 => ["Homer Simpson"], 10 => ["Jeff Baird", "Avi Flombaum"], 7 => ["Blake Johnson"]})
    end
  end

  describe '#grade' do
    it 'should be able to retreive students from a grade' do
      @school.add_student("Homer Simpson", 9)
      @school.add_student("Avi Flombaum", 10)
      @school.add_student("Jeff Baird", 10)
      @school.add_student("Blake Johnson", 7)

      @school.grade(10).should eq(["Avi Flombaum", "Jeff Baird"])
    end
  end

  describe "#sort" do
    it 'should be able to sort the students' do
      @school.add_student("Homer Simpson", 9)
      @school.add_student("Bart Simpson", 9)
      @school.add_student("Avi Flombaum", 10)
      @school.add_student("Jeff Baird", 10)
      @school.add_student("Blake Johnson", 7)
      @school.add_student("Jack Bauer", 7)

      @school.sort.should eq({7 => ["Blake Johnson", "Jack Bauer"], 9 => ["Bart Simpson", "Homer Simpson"], 10 => ["Avi Flombaum", "Jeff Baird"]})
    end
  end
end
```
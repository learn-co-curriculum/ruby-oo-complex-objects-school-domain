

# Domain Model for a School

In this assignment you'll be writing a simple app for a school. 

Create the app detailed below and get the tests passing. 

## Instructions

### Part 1. 

Write a model in the `lib` directory that stores students along with their grade 
so that the following code would run:

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

You can, of course, add several students to the same grade, and students to 
different grades.

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
 
You should be able to get a sorted list of all the students where the strings in the student arrays are sorted alphabetically. For instance:

```ruby
school.sort
# => {9 => ["AC Slater", "Zach Morris"], 10 => ["Aardvark", "Kelly Kapowski"], 11 => ["Screech", "Xavier"]}
```

Note that since hashes are unordered by nature, the order of the keys does not matter here, just the order of the student's names within each array.

## Resources
* [StackOverflow](http://stackoverflow.com/) - [What does ||= (or equals) mean in Ruby?](http://stackoverflow.com/questions/995593/what-does-or-equals-mean-in-ruby)

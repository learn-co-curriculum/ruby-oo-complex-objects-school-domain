require 'spec_helper'

describe 'School' do
  before :each do
    @school = School.new("Test School")
  end

  describe "::new" do
    it 'has an empty roster when initialized' do
      expect(@school.roster.length).to eq(0)
    end
  end

  describe "#add_student" do
    it 'is able to add a student' do
      @school.add_student("AC Slater", 10)
      expect(@school.roster).to eq({10 => ["AC Slater"]})
    end

    it 'is able to add multiple students to a class (grade)' do
      @school.add_student("Jeff Baird", 10)
      @school.add_student("Blake Johnson", 10)

      expect(@school.roster).to eq({10 => ["Jeff Baird", "Blake Johnson"]})
    end

    it 'is able to add students to different grades' do
      @school.add_student("Homer Simpson", 9)
      @school.add_student("Jeff Baird", 10)
      @school.add_student("Avi Flombaum", 10)
      @school.add_student("Blake Johnson", 7)

      expect(@school.roster).to eq({9 => ["Homer Simpson"], 10 => ["Jeff Baird", "Avi Flombaum"], 7 => ["Blake Johnson"]})
    end
  end

  describe '#grade' do
    it 'is able to retreive students from a grade' do
      @school.add_student("Homer Simpson", 9)
      @school.add_student("Avi Flombaum", 10)
      @school.add_student("Jeff Baird", 10)
      @school.add_student("Blake Johnson", 7)

      expect(@school.grade(10)).to eq(["Avi Flombaum", "Jeff Baird"])
    end
  end

  describe "#sort" do
    it 'is able to sort the students' do
      @school.add_student("Homer Simpson", 9)
      @school.add_student("Bart Simpson", 9)
      @school.add_student("Avi Flombaum", 10)
      @school.add_student("Jeff Baird", 10)
      @school.add_student("Blake Johnson", 7)
      @school.add_student("Jack Bauer", 7)

      # key order does not matter; this is testing that the students in each respective value are in alphabetical order
      expect(@school.sort).to eq({7 => ["Blake Johnson", "Jack Bauer"], 9 => ["Bart Simpson", "Homer Simpson"], 10 => ["Avi Flombaum", "Jeff Baird"]})
    end
  end

  context "database operations" do
    before(:each) do
      @student = Student.new.tap { |s| s.name = "Anything But Scott Oh Nevermind" }
    end

    #think about what you need to do to set up a database
    #and what should have the responsibility for doing that for these tests

    describe ".insert" do
      it "persists the student to the database" do
        @student.should respond_to(:insert)
        @student.insert.should eq(true)
      end
    end

    describe ".update" do
      it "updates the student in the database" do
        @student.insert
        @student.name = "Catherine"
        @student.update.should eq(true)
      end
    end

    #bonus 1:  prove it!
    describe "::load_from_database" do
      it "loads the student from the database" do
        @student.insert
        loaded = Student.load(@student.id)
        loaded.name.should eq(@student.name)
        loaded.id.should eq(@student.id)
        @student.name = "new name"
        @student.update
        updated = Student.load(@student.id)
        updated.name.should eq(@student.name)
      end
    end

    #bonus 2: use before(:each) and after(:each) to create your database
    #and set it to a default state for each test

    #bonus 3: extract the code you used in bonus 2 to a
    #new class that the test can reference to create and destroy databases
  end
end

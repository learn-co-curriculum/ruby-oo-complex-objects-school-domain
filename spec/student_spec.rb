require_relative 'spec_helper'

describe "Student" do

  it "can be instantiated" do
    Student.new.should be_an_instance_of(Student)
  end

  describe "student properties" do
    let(:student) { Student.new }

    it "has a name" do
      student.name = "Paul"
      student.name.should eq("Paul")
    end

    it "has social media links" do
      student.twitter = "paulissupercool"
      student.twitter.should eq("paulissupercool")
      student.linkedin = "paulhateslinkedin"
      student.linkedin.should eq("paulhateslinkedin")
      student.facebook = "whoisthisguypaulanyway"
      student.facebook.should eq("whoisthisguypaulanyway")
    end

    it "has a website" do
      student.website = "http://websitesarecool.com"
      student.website.should eq("http://websitesarecool.com")
    end
  end

  describe "::all" do

    it "keeps track of the students that have been created" do
      Student.reset_all

      ('a'..'c').each do |l|
        s = Student.new
        s.name = l
      end

      Student.all.count.should eq(3)
      Student.all.collect { |s| s.name }.should include('a')
    end

  end

  describe "::reset_all" do

    it "resets the set of created students" do
      10.times do
        Student.new
      end

      Student.reset_all
      Student.all.count.should eq(0)
    end

  end

  describe "::find_by_name" do

    let(:scott) { Student.new }
    let(:avi) { Student.new }

    it "can find a student by name" do
      scott.name = "Scott"
      avi.name = "Avi"

      Student.find_by_name("Scott").first.name.should eq("Scott")
      Student.find_by_name("Avi").first.should eq(avi)
    end

  end

  #BONUS ROUND! Implement an ID system
  context "with an ID" do

    let(:student) { Student.new }

    before(:each) do
      Student.reset_all
    end

    it "has an ID" do
      student.should respond_to(:id)
    end

    it "doesn't allow ID to be changed" do
      student.should_not respond_to(:id=)
    end

    it "auto-assigns an id" do
      student.name = "Becky"
      student.id.should eq(1)

      s2 = Student.new
      s2.id.should eq(2)
    end

    it "can find a student by ID" do
      student.name = "Steve"
      10.times do
        Student.new
      end

      Student.find(student.id).name.should eq("Steve")
      Student.find(student.id).should eq(student)
    end

    describe "::delete" do

      it "can be deleted" do
        student.name = "Steve"
        5.times do
          Student.new.tap { |s| s.name = "Clara" }
        end

        Student.delete(student.id)
        Student.all.collect { |s| s.name }.should_not include("Steve")
      end

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

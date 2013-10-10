require_relative 'spec_helper'
require 'sqlite3'

describe "Student" do

  before(:each) do
    @db = DBBuddy.create
  end

  after(:each) do
    DBBuddy.destroy(@db)
  end

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
      student.save
      10.times do
        Student.new
      end

      Student.find(student.id).name.should eq("Steve")
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

end

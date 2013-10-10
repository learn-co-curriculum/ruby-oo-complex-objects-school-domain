require 'sqlite3'
require_relative 'spec_helper'

describe Student do
  context "database operations" do
    before(:each) do
      @student = Student.new.tap { |s| s.name = "Anything But Scott Oh Nevermind" }
      @db = DBBuddy.create
    end

    after(:each) do
      DBBuddy.destroy(@db)
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

    describe ".save" do
      it "chooses the right thing on first save" do
        @student.should_receive(:insert)
        @student.save
      end
      it "chooses the right thing after saving" do
        @student.save
        @student.name = "Steven"
        @student.should_receive(:update)
        @student.save
      end
    end

    #bonus 1:  prove it!
    describe "::load" do
      it "loads the student from the database" do
        @student.save
        loaded = Student.load(@student.id)
        loaded.name.should eq(@student.name)
        loaded.id.should eq(@student.id)
        @student.name = "new name"
        @student.save
        updated = Student.load(@student.id)
        updated.name.should eq(@student.name)
      end

      it "finds by id" do
        @student.save
        found = Student.find(@student.id)
        found.name.should eq(@student.name)
        # mega extra credit: can you make this work
        # and preserve the id-related tests from
        # student_spec.rb?
      end
    end

    #bonus 2: use before(:each) and after(:each) to create your database
    #and set it to a default state for each test

    #bonus 3: extract the code you used in bonus 2 to a
    #new class that the test can reference to create and destroy databases
  end
end

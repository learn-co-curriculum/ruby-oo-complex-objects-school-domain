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
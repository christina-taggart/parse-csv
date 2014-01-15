require 'csv'

class Person
  # Look at the above CSV file
  # What attributes should a Person object have?
  def initialize(people_hash)
    people_hash.each do |header, value|
      instance_variable_set("@#{header}", value) unless value.nil?
    end
  end
end

class PersonParser
  attr_reader :file

  def initialize(file)
    @file = file
    @people = nil
    @array_of_people = []
  end

  def people
    # If we've already parsed the CSV file, don't parse it again.
    # Remember: @people is +nil+ by default.

    return @people if @people

    # We've never called people before, now parse the CSV file
    # and return an Array of Person objects here.  Save the
    # Array in the @people instance variable.
    CSV.foreach('people.csv', :headers => true) do |row|
      @array_of_people << Person.new(row)
    end
    @people = @array_of_people
  end
end


parser = PersonParser.new('people.csv')

puts "There are #{parser.people.size} people in the file '#{parser.file}'."
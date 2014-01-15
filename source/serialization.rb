require 'csv'

class Person
  def initialize(table)
    @id = table['id']
    @first_name = table['first_name']
    @last_name = table['last_name']
    @email = table['email']
    @phone = table['phone']
    @created_at = table['created_at']
  end
end

class PersonParser
  attr_reader :file

  def initialize(file)
    @file = file
    @people = nil
  end

  def people
    return @people if @people
    @people = Array.new
    CSV.foreach(@file, :headers => true) do |table|
      @people << Person.new(table)
    end
  end
end


#-----DRIVERS-----

parser = PersonParser.new('people.csv')
parser.people
puts "There are #{parser.people.size} people in the file '#{parser.file}'."
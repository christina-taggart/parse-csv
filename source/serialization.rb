require 'csv'
require 'date'

class Person
  attr_reader :id, :first_name, :last_name, :email, :phone, :created_at

  def initialize(id, first_name, last_name, email, phone, created_at)
      @id = id
      @first_name = first_name
      @last_name = last_name
      @email = email
      @phone = phone
      @created_at = created_at

  end

  # Look at the above CSV file
  # What attributes should a Person object have?
end

class PersonParser
  attr_reader :file, :people
  def initialize(file)
    @file = file
    @people = []
    run
  end

  def csv(file)
    File.open(file) do |x|
      header = x.readline.chomp.split(",")

      until x.eof?
        row = x.readline.chomp.split(",")
        row = header.zip(row).flatten
        @people << Hash[*row]
      end
    end
  end

  def people_maker
    @people.map! do |row| #{"id" => 1}{"id"=>2}
      Person.new(row["id"], row["first_name"], row["last_name"], row["email"], row["phone"], DateTime.parse(row["created_at"]))
    end
  end

  def run
    csv(file)
    people_maker
  end

  def add_person(person)
    @people << person
  end

  def save(file)
    File.open(file,"w") do |file|
        file.puts "id,first_name,last_name,email,phone,created_at"
      @people.each do |person|
        file.puts "#{person.id},#{person.first_name},#{person.last_name},#{person.email},#{person.phone},#{person.created_at}"
      end
    end
  end
end

parser = PersonParser.new('people.csv')



andy = Person.new(201, "Andy", "Lee", "asdf.com", "234234234", "2012-05-10T03:53:40-07:00")
parser.add_person(andy)
puts "There are #{parser.people.size} people in the file '#{parser.file}'."

parser.save("people.csv")
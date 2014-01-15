require 'csv'

class Person

  def initialize(id, first_name, last_name, email, phone, created_at)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @phone = phone
    @created_at = created_at
  end

  def properties
    [@id, @first_name, @last_name, @email, @phone, @created_at]
  end

end

class PersonParser
  attr_reader :file, :staged_to_add

  def initialize(file)
    @file = file
    @people = nil
    @staged_to_add = []
  end

  def people
    @people = []
    CSV.foreach(file) do |row|
      @people << Person.new(row[0], row[1], row[2], row[3], row[4], row[5])
    end
    @people.shift
    @people if @people
  end

  def view_people
    @people
  end

  def add_person(first_name, last_name, email, phone, created_at)
    @staged_to_add << Person.new(@people.length + 1, first_name, last_name, email, phone, created_at)
  end

  def save
    # all_people = [@field_names] + @people + staged_to_add
    CSV.open(file, "a") do |csv|
      @staged_to_add.each do |to_add|
        csv << to_add.properties
      end
    end
  end

end

parser = PersonParser.new('people.csv')
parser.people
parser.add_person("Eli", "Shkurkin", "yomama@whut.com", "555-555-5555", Time.now)
p parser.staged_to_add
puts "There are #{parser.people.size} people in the file '#{parser.file}'."
parser.save
puts "There are #{parser.people.size} people in the file '#{parser.file}'."

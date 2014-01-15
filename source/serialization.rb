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
end

class PersonParser
  attr_reader :file

  def initialize(file)
    @file = file
    @people = []
  end

  def people
   CSV.foreach(@file, :headers => true) do |row|
      @people << Person.new(row['id'], row['first_name'], row['last_name'], row['email'], row['phone'], DateTime.parse(row['created_at']))
    end
    return @people if @people
  end

  def display_people
    @people
  end

  def add_person(instance_of_person)
    @people << instance_of_person
  end

  def save
    CSV.open(@file, "a") do |csv|
      csv << [@people[-1].id, @people[-1].first_name, @people[-1].last_name, @people[-1].email, @people[-1].phone, @people[-1].created_at]
    end
  end
end

# Driver Code
parser = PersonParser.new('people.csv')
david = Person.new(201,"David","Goodman","rickismybestfriend@gmail.com","516726736","2013-01-24T02:20:11-08:00")
parser.add_person(david)
parser.save
rick = Person.new(202,"Ricardo","Rubio","davidisbestbuddyforever@aol.com","123726736","2013-08-20T22:24:59-07:00")
parser.add_person(rick)
puts "----------------------"
parser.save
puts "There are #{parser.people.size-2} people in the file '#{parser.file}'."#<Person:0x007fbe6283d790 @id=nil, @first_name=nil, @last_name=nil, @email=nil, @phone=nil, @created_at=nil>, #<Person:0x007fbe6283c2c8 @id=nil, @first_name=nil, @last_name=nil, @
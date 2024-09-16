require 'sinatra'

class User < Sequel::Model(:users)
    plugin :validation_helpers
    one_to_many :user_staff

  def name
    "#{first_name} #{surname}"
  end

  #checks userid isnt null
  def self.id_exists?(id)
    return false if id.nil? 
    return false unless Validation.str_is_integer?(id) # check the id is an integer
    return false if User[id].nil? # check the database has a record with this id

    true # id/user exists
  end

    #hashing passwords
  def pass_hash(password)
    prime = 31 # used prime numbner to hash
    hash = 0
    password.each_char do |char|
      hash = (hash * prime + char.ord) % 100_0000 # using modulo to limit to 6 digits, keeps it consistent in the database
    end
    return hash.to_s.rjust(6, '0') # convert to string + 0's (padding)
    
  end

      

  def load(params)#modified for our database
    self.userID = params.fetch("userID", "").strip
    self.first_name = params.fetch("first_name", "").strip
    self.surname = params.fetch("surname", "").strip
    self.username = params.fetch("username", "").strip
    self.email = params.fetch("email", "").strip
    self.password = params.fetch("password", "").strip
    self.password = self.pass_hash(self.password).strip
    self.suggested_courses = params.fetch("suggested_courses", "").strip

  end

  def validate
    super
    errors.add("first_name", "cannot be empty") if !first_name || first_name.empty?
    errors.add("surname", "cannot be empty") if !surname || surname.empty?
    errors.add("username", "cannot be empty") if !username || username.empty?
    errors.add("email", "cannot be empty") if !email || email.empty?
    errors.add("password", "cannot be empty") if !password || password.empty?
  end

  def ban
    update(is_banned: 1)
  end

  def unban
    update(is_banned: 0)
  end
end

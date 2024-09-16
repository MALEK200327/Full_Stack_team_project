require 'sinatra'

class User_staff < Sequel::Model(:user_staff)
    plugin :validation_helpers

    many_to_one :user
    #checks userid isnt null
  def self.id_exists?(id)
    return false if id.nil? 
    return false unless Validation.str_is_integer?(id) # check the id is an integer
    return false if User_Staff[id].nil? # check the database has a record with this id

    true # id/user exists
  end

  def load(params)
    self.userID = params.fetch("userID","").strip
    self.role = params.fetch("role","").strip
  end

  #def validate
    #super
    #validates_presence [:userID, :role]
  #end

  def validate
    super
    errors.add("role", "cannot be empty") if !role || role.empty?
  end
end


#course record

class Course < Sequel::Model(:courses)

    #checks courseid isnt null
  def self.id_exists?(id)
    return false if id.nil? 
    return false unless Validation.str_is_integer?(id) # check the id is an integer
    return false if Course[id].nil? # check the database has a record with this id

    true # id/course exists
  end

  def load(params)#modified for our database
    self.course_title = params.fetch("course_title", "").strip
    self.description = params.fetch("description", "").strip
    self.url = params.fetch("url", "").strip
    self.private = params.fetch("private", "").strip
  end

  def validate
    super
    errors.add("course_title", "cannot be empty") if !course_title || course_title.empty?
    errors.add("description", "cannot be empty") if !description || description.empty?
    errors.add("url", "cannot be empty") if !url || url.empty?
  end

end
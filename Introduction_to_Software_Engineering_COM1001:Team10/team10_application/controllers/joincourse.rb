# GET route to show form for joining a course
get "/joincourse" do
  @logged_in = !session[:user_id].nil?
  # Find the user in the database using the ID
  @user = User[session[:user_id]]
  
  # Find all available courses in the database
  @courses = Course.all
  
  # Render the joincourse form
  erb :joincourse
end

# POST route to process the form for joining a course
post "/joincourse" do

  # Find the user in the database using the ID
  @user = User[session[:user_id]]
  
  # Get the ID of the selected course from the form
  course_id = params[:course_id].to_i
  
  # Find the course in the database using the ID
  course = Course.where(courseID: course_id).first
  coursetitle = course.course_title

  if UsersCourse.where(user: @user, course: course).count > 0
    erb :failedjoin
  else 
    user_course = UsersCourse.new(user: @user, course: course)
    user_course.save_changes
    erb :learner_page
  end 
end
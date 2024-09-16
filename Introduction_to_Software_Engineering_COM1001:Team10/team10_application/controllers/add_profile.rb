require '/home/codio/workspace/project/team10_application/models/user_staff.rb'

get "/add_profile" do
    @user = User.new
    erb :add_profile
  end
  
  post "/add_profile" do
    @user = User.new
    @user.load(params)
#creating a selection list of courses to enlist in during profile creation
#redirecting page back to relevant destination due to role
  courses = []
  courses << "Architecture" if params["course1"]
  courses << "Business Management" if params["course2"]
  courses << "Engineering" if params["course3"]
  courses << "Economics" if params["course4"]
  courses << "Law" if params["course5"]
  courses << "Medicine" if params["course6"]
  courses << "Social Science& Arts" if params["course7"]
  @user.suggested_courses =courses.join(",")

    if @user.valid?
      @user.save_changes
      role = params["role"]
      user_staff = User_staff.new
      user_staff[:userID] = @user.userID
      user_staff[:role] = role
      user_staff.save
      if role =="admin"
        erb:admin_page
      elsif role == "moderator"
        erb:moderator_page
      elsif role == "learner"
        erb:learner_page
      elsif role == "manager"
        erb:admin_page
      else
        redirect "/dashboard"
      end
    else
      erb :add_profile
    end 

end
  
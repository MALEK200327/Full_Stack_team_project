get "/edit_profile/:userID" do
    id = params["userID"]
    @user = User[id] if User.id_exists?(id)
    erb :edit_profile
end
#fetches current data in user file to be editted by admins and users
post "/edit_profile/:userID" do
    id = params["userID"]
  
    if User.id_exists?(id)
      @user = User[params[:userID]]
      @user.load(params)

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
        redirect "/search_profile"
      end
    end
  
    erb :edit_profile
  end
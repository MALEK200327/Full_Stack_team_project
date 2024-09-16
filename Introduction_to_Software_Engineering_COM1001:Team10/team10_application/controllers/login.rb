#controller for login page

get "/login" do
    @blank_errors = 0
    erb :login
end
    
post "/login-check" do
#validating login 
  @users = User.all
  @user_staff = User_staff.all

  @uname = params["uname_field"]
  @pass = params["pass_field"]

  @valid_entry = (!@uname.empty? && !@pass.empty?)
  @login_succesful = false
  @check_ban = false

  if (@valid_entry)

    #sanitation
    @uname.strip!
    @pass.strip!

    #validation
    @users.each do |user|
      if (@uname==user.username && user.pass_hash(@pass) ==user.password)#reverts the issue of hashed passwords to check
        @login_succesful = true 
        session[:user_id] = user.userID 
        @user = User[session[:user_id]]
        if user
          staff = User_staff.find(userID: user.userID)
          session[:role] = staff.role
          if @user.is_banned == 1 #checks for ban to see if the profile can login
            @check_ban = true
            erb :login
          else
            redirect "/dashboard"
          end

          if staff.role =="admin"#dictates directed page due to role
            erb:admin_page
          elsif staff.role == "moderator"
            erb:moderator_page
          elsif staff.role == "learner"
            erb:learner_page
          elsif staff.role == "manager"
            erb:admin_page
          else
            redirect "/dashboard"
          end
        end
      end
    end

    @blank_errors = 0
    
  else 
    if (@uname.empty? && @pass.empty?)
      @blank_errors = 1
    elsif (@uname.empty?)
      @blank_errors = 2
    else 
      @blank_errors = 3
    
    end
    erb :login

    
  end
  erb :login
end
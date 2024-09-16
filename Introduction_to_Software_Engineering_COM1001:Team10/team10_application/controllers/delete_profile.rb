

post "/delete_profile" do
    id = params["id"]
  #fetches parameters using user model to select which profile to delete on clicking a button
    if User.id_exists?(id)
      user_staff = User_staff.where(userID: id).first
      DB.transaction do
        user = User[id]
        user_staff.delete if user_staff
        user.delete
      end
      redirect "/search_profile"
    end
  
    erb :delete_profile
  end
  
get "/banning" do
    @user = User.all
    erb :ban_users
end
#uses user model to get relevant information needed to add the ban condition into the database
get "/banning/ban" do
    id = params["id"]
    user = User[id]
    user.ban
    user.save_changes
    redirect "/banning"
end
  
get "/banning/unban" do
    id = params["id"]
    user = User[id]
    user.unban
    user.save_changes
    redirect "/banning"
end
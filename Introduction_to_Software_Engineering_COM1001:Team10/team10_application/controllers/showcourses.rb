get '/showcourses' do
  @logged_in = true
  if session[:user_id].nil?
    @logged_in = false
  else
    @user = User[session[:user_id]]#uses user id recorded by the session to find courses theyre in
    @usercourses = UsersCourse.where(userID: @user.userID).all
  end
  erb :showcourses
end






  
get "/search_profile" do
    @email_search = params.fetch("email_search", "").strip
  
    @users = if @email_search.empty?
                 User.all
               else
                 User.where(Sequel.like(:email, "%#{@email_search}%"))#fetches email from database
               end
    erb :search_profile
  end
  
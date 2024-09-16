get '/unban-user-request' do
    erb :unban-user-request
end

post '/submit' do
    name = params[:name]#fetches relevent neded info to be unbanned
    reason = params[:reason].strip
    email = params[:email]

    if name.empty?
        @name_error = "Name is required"
    end

    if email.empty?
        @email_error = "Email is required"
    elsif !/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(email)
        @email_error = "Invalid email"
    end

    if reason.empty?
        @reason_error = "Reason is required"
    end

    if @name_error || @email_error || @reason_error
        erb :unban-user-request
    end
end  
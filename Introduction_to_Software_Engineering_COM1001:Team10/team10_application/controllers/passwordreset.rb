get '/passwordresest' do
    erb :passwordreset
  end
  
  post '/reset_password' do
    email = params[:email]
  
    if email.empty?
      @email_error = "Email is required"
    elsif !/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(email)#asks for your email so youy can be sent a password reset request
      @email_error = "Invalid email"
    end
  
    if @email_error 
      erb :passwordreset
    else
      redirect '/thank_you'
    end
end

get '/thank_you' do
    erb :thank_you
end
get '/report_form' do
  erb :report_form
end

# Handle the form submission and saintisation using strip
post '/submit_problem' do
  name = params[:name]
  email = params[:email]
  problem = params[:problem].strip

  # validate inputs
  if name.empty?
    @name_error = "Name is required"
  end

  if email.empty?
    @email_error = "Email is required"
  elsif !/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(email)
    @email_error = "Invalid email"
  end

  if problem.empty?
    @problem_error = "Problem description is required"
  end

  # if there are errors, show the form with error messages
  if @name_error || @email_error || @problem_error
    erb :report_form
  else
    # redirect to thank you page
    redirect '/thank_you'
  end
end

# Show the thank you page
get '/thank_you' do
  erb :thank_you
end
  

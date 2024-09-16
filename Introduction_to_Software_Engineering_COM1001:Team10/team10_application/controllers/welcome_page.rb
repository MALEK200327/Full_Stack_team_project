get '/' do
  erb :welcome_page
end

get '/report_form' do
    erb :report_form
  end

  
get '/login' do
  erb :login
end
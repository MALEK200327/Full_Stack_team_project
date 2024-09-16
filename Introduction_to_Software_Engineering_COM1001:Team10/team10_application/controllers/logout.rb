get "/logout" do
    session.clear
    erb :logout
end

post "/welcome_page" do
    erb :welcome_page
end


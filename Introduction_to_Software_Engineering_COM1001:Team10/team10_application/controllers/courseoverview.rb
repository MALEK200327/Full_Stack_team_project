require_relative "../helpers/validation"
get "/courseoverview" do 
  @course = Course[params[:id]]
  erb :courseoverview
end
#fetches course data to be formatted by view




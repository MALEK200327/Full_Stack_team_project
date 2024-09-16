get "/addcourse" do
  @course = Course.new
  erb :addcourse
end
#uses course model to load needed information into the database
post "/addcourse" do
  @course = Course.new
  @course.load(params)

  if @course.valid?
      @course.save_changes
      redirect "/searchcourse"
  else
    @errors = @course.errors
    erb :addcourse
  end 
end


get "/deletecourse" do
  id = params["id"]
  @course = Course[id] if Course.id_exists?(id)
  erb :deletecourse
end
#uses course model to fetch parameters needed to delete selected course
post "/deletecourse" do
  id = params["id"]

  if Course.id_exists?(id)
    course = Course[id]
    course.delete
    redirect "/searchcourse"
  end

  erb :deletecourse
end

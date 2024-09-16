require_relative "../helpers/validation"

get "/editcourse" do
  id = params["id"]
  @course = Course[id] if Course.id_exists?(id)
  erb :editcourse
end
#fetches relevent course details using course model to be edited
post "/editcourse" do
  id = params["id"]

  if Course.id_exists?(id)
    @course = Course[id]
    @course.load(params)

    if @course.valid?
      @course.save_changes
      redirect "/searchcourse"
    end
  end

  erb :editcourse
end



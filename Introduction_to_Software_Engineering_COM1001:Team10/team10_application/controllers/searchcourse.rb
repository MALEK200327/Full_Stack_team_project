get "/searchcourse" do
    @course_search = params.fetch("course_search", "").strip

    @courses = if @course_search.empty?
        Course.all
    else
        Course.where(Sequel.like(:course_title, "%#{@course_search}%"))#fetches course from database
    end

    erb :searchcourse
end
    
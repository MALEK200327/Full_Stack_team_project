get '/dashboard' do
    case session[:role]
    when 'admin'
      # display admin dashboard
      redirect "/dashboard_admin"
    when 'learner'
      # display learner dashboard
      redirect "/dashboard_learner"
    when 'moderator'
      # display moderator dashboard
      redirect "/dashboard_moderator"
    else
      # handle invalid user role
      redirect "login"
    end
  end
  
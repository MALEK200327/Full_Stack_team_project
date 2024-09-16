#demonstration ruby document

require "sinatra" 

include ERB::Util

# Sessions
enable :sessions
set :session_secret, "2144158d77cd477ee347c66208645275fedf877de0cdf56173b229f934e619e2"

require "require_all"

require_rel "controllers/demo.rb", "db/team10_database", "models", "controllers", "helpers"
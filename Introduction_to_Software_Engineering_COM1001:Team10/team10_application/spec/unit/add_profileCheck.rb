require "rspec"
require "rack/test"

require_relative "../../app"

RSpec.describe "Test for Add Profile Page" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "GET /add_profile" do
    it "renders the add_profile template" do
      get "/add_profile"
      expect(last_response).to be_ok
      expect(last_response.body).not_to be_empty
    end
  end

  describe "POST /add_profile" do
    it "creates a new user profile and redirects based on role (admin)" do
      post "/add_profile", {
        "course1" => "Architecture",
        "course2" => "Business Management",
        "course3" => "Engineering",
        "course4" => "Economics",
        "course5" => "Law",
        "course6" => "Medicine",
        "course7" => "Social Science& Arts",
        "role" => "admin"
      }

      
      expect(last_response).to be_redirect
      follow_redirect!

      expect(last_response).to be_ok
      expect(last_response.body).to eq("/admin_page")
    end

    it "creates a new user profile and redirects based on role (moderator)" do
      post "/add_profile", {
        "course1" => "Architecture",
        "course2" => "Business Management",
        "course3" => "Engineering",
        "course4" => "Economics",
        "course5" => "Law",
        "course6" => "Medicine",
        "course7" => "Social Science& Arts",
        "role" => "moderator"
      }

      
      expect(last_response).to be_redirect
      follow_redirect!

      expect(last_response).to be_ok
      expect(last_response.body).to eq("/moderator_page")
    end
    
    it "creates a new user profile and redirects based on role (learner)" do
        post "/add_profile", {
          "course1" => "Architecture",
          "course2" => "Business Management",
          "course3" => "Engineering",
          "course4" => "Economics",
          "course5" => "Law",
          "course6" => "Medicine",
          "course7" => "Social Science& Arts",
          "role" => "learner"
        }

      
        expect(last_response).to be_redirect
        follow_redirect!
  
        expect(last_response).to be_ok
        expect(last_response.body).to eq("/learner_page")
    end 

    it "renders the add_profile template if user profile is invalid" do
      post "/add_profile", {
        "course1" => "0",
        "course2" => "0",
        "course3" => "0",
        "course4" => "0",
        "course5" => "0",
        "course6" => "0",
        "course7" => "0",
        "role" => "invalid_role"
      }

      expect(last_response).to be_ok
      expect(last_response.body).to include("Please correct the errors below:")
    end
  end
end


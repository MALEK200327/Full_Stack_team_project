require "rspec"
require "rack/test"

require_relative "../../app"

RSpec.describe "Test for Login Page" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "Form Submission" do
    it "is successful if both uname and pass are correct" do
      post "/login-check", "uname" => "uname", "pass" => "pass"
      expect(last_response.body).to include("Login Successful!")
    end

    it "isnt successful if both fields are filled but incorrect" do
      post "/login-check", "uname" => "wrong", "pass" => "wrong"
      expect(last_response.body).to include("Please correct the errors below")
      expect(last_response.body).to include("No Account Found")
    end

    it "form is rejected if uname not filled" do
      post "/login-check", "uname" => "", "pass" => "pass"
      expect(last_response.body).to include("Please enter a username")
    end

    it "form is rejected if pass not filled" do
      post "/login-check", "uname" => "uname", "pass" => ""
      expect(last_response.body).to include("Please enter a password")
    end

  end
end

require "rspec"
require "rack/test"

require_relative "../../app"

RSpec.describe 'App' do
    include Rack::Test::Methods

def app
    Sinatra::Application
  end
  
  describe 'GET /addcourse' do
  it 'shows the form' do
    get '/addcourse'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Add Course')
  end
end

describe 'POST /addcourse' do
    it 'creates a new course and redirects to searchcourse page' do
      post '/addcourse', params = {
        course_title: 'Test Course',
        description: 'This is a test course.',
        url: 'test.com'
      }
      expect(last_response).to be_redirect
      expect(last_response.location).to include("/searchcourse")
    end
  
    it "displays appropriate error messages when one or more fields are empty" do
      empty_fields = [
        { course_title: '', description: 'This is a test course.', url: 'test.com' },
        { course_title: 'Test Course', description: '', url: 'test.com' },
        { course_title: 'Test Course', description: 'This is a test course.', url: '' }
      ]
      empty_fields.each do |params|
        post '/addcourse', params
        expect(last_response).to be_ok
        expect(last_response.body).to include('Add Course')
        expect(last_response.body).to include('Please correct the errors below: ')
        expect(last_response.body).to include('Course Title cannot be empty') if params[:course_title].empty?
        expect(last_response.body).to include('Description cannot be empty') if params[:description].empty?
        expect(last_response.body).to include('Course Url cannot be empty') if params[:url].empty?
      end
    end
  end  
end

  



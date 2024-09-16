require_relative "../../app"
require 'rspec'
require 'rack/test'

describe 'App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'shows the form' do
    get '/report_form'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Report a Problem')
  end

  it 'handles valid form submission' do
    post '/submit_problem', { name: 'John Doe', email: 'johndoe@example.com', problem: 'I have a problem' }
    expect(last_response.redirect?).to be true
    follow_redirect!
    expect(last_request.path).to eq('/thank_you')
  end

  it 'handles invalid form submission' do
    post '/submit_problem', { name: '', email: 'invalidemail', problem: '' }
    expect(last_response).to be_ok
    expect(last_response.body).to include('Report a Problem')
    expect(last_response.body).to include('Name is required')
    expect(last_response.body).to include('Invalid email')
    expect(last_response.body).to include('Problem description is required')
  end

  it 'handles invalid form submission with missing problem' do
    post '/submit_problem', { name: 'John Doe', email: 'johndoe@example.com', problem: '' }
    expect(last_response).to be_ok
    expect(last_response.body).to include('Report a Problem')
    expect(last_response.body).to include('Problem description is required')
  end

  it 'handles invalid form submission with invalid email and missing problem' do
    post '/submit_problem', { name: 'John Doe', email: 'invalidemail', problem: '' }
    expect(last_response).to be_ok
    expect(last_response.body).to include('Report a Problem')
    expect(last_response.body).to include('Invalid email')
    expect(last_response.body).to include('Problem description is required')
  end

  it 'handles invalid form submission with missing name and invalid email' do
    post '/submit_problem', { name: '', email: 'invalidemail', problem: 'I have a problem' }
    expect(last_response).to be_ok
    expect(last_response.body).to include('Report a Problem')
    expect(last_response.body).to include('Name is required')
    expect(last_response.body).to include('Invalid email')
  end
end
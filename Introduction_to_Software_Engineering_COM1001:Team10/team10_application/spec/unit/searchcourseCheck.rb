require relative "../../app"
require 'rspec'
require 'rack/test'

desribe 'App' do
   include Rack::Test::Methods

    def app
        Sinatra::Application
    end

    it 'shows form' do
        get '/searchcourse'
        expect(last_reposnse).to be_ok
        expect(last_reponse.body).to include ('Search Course')
    end

    it 'allows access to add course page' do
        visit "/addcourse"
        click_link "Add a new course to the database"
        expect(page).to have_content "Search Course"
    end
end
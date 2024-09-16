Com1001. Team 10 Application.

To download our application follow these steps:

1. Open a terminal or Command Prompt.

2. Clone Team 10’s Git repository in your preferred folder.
    [ > {folder}$ git clone https://git.shefcompsci.org.uk/com1001-2022-23/team10/project.git ]

3. Bundle install within the application file to install our gemfile
    [ > ~/team10_application$ bundle install ]

To use our application, run this command in the application file:
    [ > ~/team10_application$ sinatra app.rb]


If program is throwing errors, try:
1. sudo gem install sinatra
2. sudo gem install sqlite3 -v 1.5


To run our automated tests:
1. Navigate to the /spec/unit folder in the application file
    [ > ~/spec/unit$ ]
2. Run your desired test with this command
    [ > ~/spec/unit$ rspec {desired test}.rb ]
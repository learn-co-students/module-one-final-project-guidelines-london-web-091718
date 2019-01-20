# GitHub Job search and City Quality of Life project

This software finds GitHub job listings using GitHub's API and saves it to the user's search history. After the user has read through the listing, they have the option to check the Quality of life stats of said city using the Socrata API and/or to open the listing in their default browser to proceed with their job application. The application:

- Creates or finds the user from a database
- Asks the user to type in a city/keywords for the job listings
- Asks the user if they would like to store the current search in their profile
- Allows to select the particular listing
- Shows the listing with all HTML tags stripped
- Asks the user if they would like to view the city statistics
- Allows to open the job listing in the user's default browser
- Saves the data stats to the database for further use

Additionally:

- User is able to see their history or return to main menu/exit the app at almost any point
- Various text elements are in different colours for ease of use and readability


# Installation:

To install:
1. Clone the repository
2. Run $ bundle install
3. Run $ rake db:migrate
4. $ ruby bin/run.rb to launch the CLI.

# Usage  

Use arrow keys to navigate the interface, use space or enter to select an item.

The CLI uses native ruby gems with the addition of:
-ActiveRecord,
-TTY-prompt,
-Rainbow,
-Launchy,
-Terminal Table,
-Rest-Client
-SQlite3.

All of the gems provided on rubygems. Documentation for each gem can be found in their respectful repositories.

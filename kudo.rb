require 'rubygems'
require 'capybara'

require_relative 'lib/wait'

require 'dotenv'
Dotenv.load

session = Capybara::Session.new(:selenium)

session.visit 'https://www.strava.com/login'
session.fill_in 'email', with: ENV['STRAVA_EMAIL']
session.fill_in 'password', with: ENV['STRAVA_PASSWORD']
session.click_button 'Log In'

session.wait 'https://www.strava.com/dashboard'

session.all('.feed .activity').each do |activity|
  user_name = activity.find('a.entry-owner').text
  date_time = activity.find('time.timestamp', match: :first).text
  title = activity.find('h3.title-text a').text

  begin
    activity.find('button.js-add-kudo').click
    puts "gave kudos on #{title}, #{user_name}, #{date_time}"
  rescue Capybara::ElementNotFound
  end
end

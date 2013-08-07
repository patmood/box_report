#Box Report

Ever wondered what's taking up all that space in your dropbox? Visualize and explore the contents of your dropbox to easily find the files or folders taking up the most space.

Site built with Sinatra.  Authentication using Dropbox API. Graphs with Google Charts

DEMO:
<http://box-report.herokuapp.com/>
(NOTE: App status not in production, you will need your own API keys)

##Development

To run this app you'll need:

Ruby 1.9.3

Postgresql 9.2+



##Install

- Fork the repo and clone the files onto your local machine:

      $ git clone https://github.com/patmood/box_report.git

- Create a Dropbox App <https://www.dropbox.com/developers>

- Add your own Dropbox Application KEY and SECRET to config/environment.rb

- Navigate to the application directory in terminal and run **bundle install** to gather the required gems:

      $ bundle install

- You'll likely need to edit those settings for your local machine. Now you need to create and set up the database:

      $ rake db:create

      $ rake db:migrate

- Launch your sinatra application server (Recommend Shotgun)

- Open a broswer and navigate to localhost:9393 (if using Shotgun)

- Enjoy!

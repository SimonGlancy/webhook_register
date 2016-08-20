# webhook_tracker

#### Introduction

This is a solution to the following problem:

Implement a web application in Ruby that:
* can receive web hooks from Mandrill
* processes the web hook data and stores it into a suitable data store
* displays the following statistics
  * total number of emails sent
  * total number of emails opened
  * total number of clicks
  * open rate per email type
  * click rate per email type

#### Sample data
Here are some example payloads:

` {"Address":"barney@lostmy.name","EmailType":"Shipment","Event":"send","Timestamp":1432820696}
  {"Address":"tom@lostmy.name","EmailType":"UserConfirmation","Event":"click","Timestamp":1432820702}
  {"Address":"vitor@lostmy.name","EmailType":"Shipment","Event":"open","Timestamp":1432820704}`

#### Application details

The app is built using Rails (v5.0.0.1) and Ruby (v2.2.2) with a postgresql database. Additional Gems responders for producing the JSON output and rack-cors to enable cross origin requests were used. Tests are written in RSPEC.

the app contains two routes:

* index - This is the get route ('/') that presents the information requested in JSON format (total number of emails sent, total number of emails opened, total number of clicks, open rate per email type, click rate per email type)

* create - This is a post route ('/emails') that creates a new instance in the postgresql database Webhook table with the following columns( address: string, email_type: string, event: string:, timestamp)

#### Assumptions

1). Open/click rate means number of open/click actions divided by number of send actions per email type.

2). App is to be used as an API or micro-service so presentation in JSON format in browser is acceptable. No views have been provided.

3). Database columns are written in snake_case to be in keeping with Ruby (conversly to the format of data from llirdnam tool). This is because column names are used as methods within the Model and having CamelCase methods feels un Rubyish.

#### Launch the app

1). clone this repo

2). `bundle`

3). `db:create`

4). `db:migrate`

5). `db:migrate RAILS_ENV=test`

6). `rails s`

7). visit http://localhost:3000/


#### Challenges/Discussion

I thought this was an excellent challenge quite complex and lead to some good OO design within the Model to adhere to the separation of concerns and I managed to keep the controller quite skinny. It went very smoothly up until I tried to implement the llirdnam tool for posting webhooks that was supplied. I had an extensive test suite that catered for all issues raised in the challenge. I found that implementing the llirdnam lead to the information entering the app in an unwanted format, not through the params method as I would have expected. To acces the data I had to parse the body of the request into a hash that could be passed into the Webhook create method. I made a decision that I wanted to keep both my idealised solution and the llirdnam solution to I introduced a guard clause that checked whether the params had the strong parameter :webhook and catered for each outcome accordingly. This allowed my app to work with the llirdnam tool without having to change my test suite.

#### Improvements

I would move self.find_total(query_params), self.find_percentage(email_type, event_type), self.create_hash_for(event_type) methods to private in the model. This would lead to me only having one test and for the nature of this excercise I wanted to keep the tests to show how I arrived at my solution.

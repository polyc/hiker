Feature: Login into Hiker App

Scenario: click on login button
Given I am on the Hiker landing page
When I click on login button
Then I should see login page

Scenario: email/nickname login
Given I am on the Hiker login page
When I sign in
Then I should see my homefeed

#Scenario: facebook signup/login
#Given I am on the Hiker login page
#When I sign in with Facebook
#Then I should see my homefeed

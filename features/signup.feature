Feature: Signup into Hiker App

Scenario: click on signup button
Given I am on the Hiker landing page
When I click on signup button
Then I should see signup page

Scenario: signup to Hiker App
Given I am on the Hiker signup page
When I signup
Then I should see hike preferences setup page

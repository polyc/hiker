Feature: home page

Background:
Given I am on Hiker home page
Given I am signed in as id="1"
Given I have hikes on my home feed

Scenario: view hike creator

When I click on the hike's creator name
Then I should see the hike's creator profile id="2"

Scenario: view hike's more info

When I click on more info
Then I should see "2" page

Scenario: add hike to favourites
When I click on add to favourites
Then I should see a banner "successfully added to my favorite hikes"
Then I should see a link remove hike from favourites

Scenario: remove hike from favourites
Given I have the hike in my favourite hikes
When I click on remove from favourites
Then I should see "2" page

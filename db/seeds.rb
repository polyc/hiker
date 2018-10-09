# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

more_users = [
	{:name => 'Giulio', :surname => 'Rossi', :nickname => 'giu', :gender => 'male', :birthdate => '2018-10-08 00:00:00', :email => 'giu@gmail.it', :city => 'Milano', :hike_pref => '["T", "E", "EE", "EAI"]', :password => 'provaacaso', :password_confirmation => 'provaacaso' },

	{:name => 'Gabriele', :surname => 'Rossi', :nickname => 'gab', :gender => 'male', :birthdate => '2018-10-08 00:00:00', :email => 'ga@gmail.it', :city => 'Roma', :hike_pref => '["T", "E", "EE"]', :password => 'provaacaso', :password_confirmation => 'provaacaso' },

	{:name => 'Fabrizio', :surname => 'Rossi', :nickname => 'fab', :gender => 'male', :birthdate => '2018-10-08 00:00:00', :email => 'fa@gmail.it', :city => 'Empoli', :hike_pref => '["T"]', :password => 'provaacaso', :password_confirmation => 'provaacaso' },

	{:name => 'Anna', :surname => 'Rossi', :nickname => 'anna', :gender => 'female', :birthdate => '2018-10-08 00:00:00', :email =>'anna@gmail.it', :city => 'Bologna', :hike_pref => '["T","EE", "EAI"]', :password => 'provaacaso', :password_confirmation => 'provaacaso' }


]

more_users.each do |user|
  User.create!(user)
end

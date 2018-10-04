FactoryBot.define do
    factory :user do
      name  {"Gianni"}
      surname {"Alemanno"}
      nickname {"baffo"}
      gender {"male"}
      email {"baffo@gmail.com"}
      birthdate {"2018-09-28 00:00:00"}
      password {"passwordacaso"}
      #image { fixture_file_upload "#{Rails.root}/spec/fixtures/images/image.jpg", 'image/jpg' }
      city {"Rome"}
      hike_pref {["T", "E", "EE", "EEA", "EAI"]}
    end

    
end

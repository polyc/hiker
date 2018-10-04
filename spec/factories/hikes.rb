FactoryBot.define do
    factory :hike do
      name  {"Passeggiata"}
      equipment {"Scarpe da trekking, corda, zaino, borraccia"}
      difficulty {"P"}
      distance {5.6}
      nature {"Pini, abeti, Orsi"}
      max_height {1000.7}
      min_height {500.7}
      level_difference {500}
      rating {4.5}
      tipo {"EE"}
      description {"Passeggiata nel bosco"}
    end
end

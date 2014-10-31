FactoryGirl.define do
  factory :game do
    creator_id { 1 }

    factory :accepted_game do
      creator_id { 1 }
      accepted_at { 1.day.ago }
      white_id { 1 }
      black_id { 2 }
    end
  end
end

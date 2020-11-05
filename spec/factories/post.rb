FactoryBot.define do
  factory :post do
    user
    sequence :title do |n|
      "title_sample_#{n}"
    end
  end
end

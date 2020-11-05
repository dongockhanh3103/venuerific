FactoryBot.define do
  factory :post do
    # user
    sequence :title do |n|
      "title_sample_#{n}"
    end

    after(:build) do |post|
      post.picture.attach(
        io: open('https://cdn.pixabay.com/photo/2015/05/31/15/07/business-792113_1280.jpg'),
        filename: "picture_#{i}.jpg")
    end
  end
end

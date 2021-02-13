FactoryBot.define do
  factory :item do
    association :user
    name {"商品"}
    info {"これは商品です"}
    category_id {1}
    condition_id {1}
    delivery_fee_id {1}
    prefecture_id {1}
    shipping_time_id {1}
    price {"5000"}

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
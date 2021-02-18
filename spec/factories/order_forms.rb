FactoryBot.define do
  factory :order_form do
    association :user
    association :item
    token {"tok_abcdefghijk00000000000000000"}
    postal_code {'123-4567'}
    prefecture_id {1}
    municipality {'甲府市'}
    address {'1-1'}
    building_name {'甲府ハイツ'}
    phone_number {'08033337272'}
  end
end

class Item < ApplicationRecord
  with_options presence:true do
    validates :name
    validates :info
    validates :category_id
    validates :condition_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :shipping_time_id
    validates :price
  end
  belongs_to :user
  has_one_attached :image
end
class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :info
    validates :price
  end

  belongs_to :user
  has_one_attached :image
  validate :image, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :shipping_time

  with_options presence: true, numericality: { other_than: 0 } true do
    validates :category_id
    validates :condition_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :shipping_time_id
  end
end

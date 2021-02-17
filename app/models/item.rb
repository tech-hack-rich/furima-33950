class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  with_options presence: true do
    validates :image
    validates :name
    validates :info
    with_options numericality: { other_than: 0, message: 'Select' } do
      validates :category_id
      validates :condition_id
      validates :delivery_fee_id
      validates :prefecture_id
      validates :shipping_time_id
    end
    validates :price, numericality: { with: /\A[0-9]+\z/, message: 'Half-width number' }
    validates :price, numericality: { greater_than: 300, less_than: 9_999_999, message: 'Out of setting range' }
  end

  # アソシエーション
  belongs_to :user
  has_many :orders
  # activestorageのアソシエーション
  has_one_attached :image
  # activehashのアソシエーション
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :shipping_time
end

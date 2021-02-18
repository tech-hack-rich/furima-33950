class OrderForm
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :order_id, :postal_code, :prefecture_id, :municipality, :address, :building_name, :phone_number

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "Input correctly"}
    validates :prefecture_id, numericality: { other_than: 0, message: 'Select' }
    validates :municipality
    validates :address
    validates :phone_number, format: {with: /\A\d{10}\z|\A\d{11}\z/ , message: "Input only number"}
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)

    OrderAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, address: address, phone_number: phone_number, building_name: building_name, order_id: order.id)
  end
end
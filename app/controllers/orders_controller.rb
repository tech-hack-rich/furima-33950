class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :item_find
  before_action :user_match
  before_action :item_sold?

  def index
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :municipality, :address,
                                       :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def item_find
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
  
  def user_match
    if current_user == @item.user
      redirect_to root_path
    end
  end

  def item_sold?
    if @item.order.present?
      redirect_to root_path
    end
  end

end

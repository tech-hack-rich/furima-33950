class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
  end

  private

  def item_params
    params.require(:item).permit(:name, :info, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :shipping_time_id, :price).merge(user_id: current_user.id)
  end
end
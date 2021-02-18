class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :item_find, only: [:show, :edit, :update, :destroy]
  before_action :user_match, only: [:edit, :update, :destroy]
  before_action :item_sold, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :info, :category_id, :condition_id, :delivery_fee_id, :prefecture_id,
                                 :shipping_time_id, :price).merge(user_id: current_user.id)
  end

  def item_find
    @item = Item.find(params[:id])
  end

  def user_match
    redirect_to root_path unless current_user == @item.user
  end

  def item_sold
    if Order.exists?(item_id: @item.id)
      redirect_to root_path
    end
  end
end

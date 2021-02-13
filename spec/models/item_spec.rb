require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品出品' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '商品出品できる時' do
      it '商品出品フォームの項目を全て正しく入力すれば登録できること' do
        expect(@item).to be_valid
      end
    end

    context '商品が出品できないとき' do
      it 'userが存在しないと出品できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end

      it 'imageがないと出品できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'nameがないと出品できないこと' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'infoがないと出品できないこと' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end

      it 'category_idが未選択(id: 0)だと出品できないこと' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category Select")
      end

      it 'condition_idが未選択(id: 0)だと出品できないこと' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition Select")
      end

      it 'delivery_fee_idが未選択(id: 0)だと出品できないこと' do
        @item.delivery_fee_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee Select")
      end

      it 'prefecture_idが未選択(id: 0)だと出品できないこと' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture Select")
      end

      it 'shipping_time_idが未選択(id: 0)だと出品できないこと' do
        @item.shipping_time_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping time Select")
      end

      it 'priceがないと出品できないこと' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが¥300~¥9,999,999の間でないと出品できないこと(300円未満のとき)' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end

      it 'priceが¥300~¥9,999,999の間でないと出品できないこと(10,000,000円以上のとき)' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end

      it 'priceが半角アルファベットでは出品できないこと' do
        @item.price = 'aaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end

      it 'priceが全角数字では出品できないこと' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end
    end
  end
end

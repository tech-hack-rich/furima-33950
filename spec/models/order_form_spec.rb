require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  describe '商品購入機能' do
    before do
      #bundle exec rspec spec/models/order_form_spec.rb
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_form = FactoryBot.build(:order_form, user_id: user.id, item_id: item.id)
      sleep(0.02)
    end

    context '商品が購入できるとき' do
      it '商品購入フォームの項目を正しく入力してtokenがあれば購入できること' do
        expect(@order_form).to be_valid
      end
      it 'building_nameは空でも購入できる' do
        @order_form.building_name = ''
        expect(@order_form).to be_valid
      end
    end

    context '商品が購入できないとき' do
      it 'tokenが空では購入できない' do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeが空では購入できない' do
        @order_form.postal_code = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeはハイフンがないと登録できない' do
        @order_form.postal_code = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Postal code Input correctly')
      end
      it 'prefecture_idが未選択では購入できない' do
        @order_form.prefecture_id = 0
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture Select")
      end
      it 'municipalityが空では購入できない' do
        @order_form.municipality = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'addressが空では購入できない' do
        @order_form.address = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberがからでは購入できない' do
        @order_form.phone_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberは数字でないと購入できない' do
        @order_form.phone_number = 'aaaaaaaaaaa'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number Input only number')
      end
      it 'phone_numberは12けた以上では購入できない' do
      end
    end
  end
end
require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる時' do
      it '新規登録フォームの項目を全て正しく入力すれば登録できること' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない時' do
      it 'nickname は空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailが重複していると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは、@を含まないと登録できない' do
        @user.email = 'tarou.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")

      end

      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordは、6文字以上でないと登録できない' do
        @user.password = '1a234'
        @user.password_confirmation = '1a234'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordは、数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end

      it 'passwordは、英語のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end

      it 'passwordは、全角では登録できない' do
        @user.password = '秘密の鍵です'
        @user.password_confirmation = '秘密の鍵です'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end

      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'password_confirmationは、passwordと一致してないと登録できない' do
        @user.password = '12345a'
        @user.password_confirmation = '12345b'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'family_nameが空だと登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end

      it 'family_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.family_name = 'yamanashi'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name Full-width characters")
      end

      it 'first_nameが空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.first_name = 'tarou'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name Full-width characters")
      end

      it 'family_name_spellが空だと登録できない' do
        @user.family_name_spell = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name spell can't be blank")
      end

      it 'family_name_spellが全角（カタカナ）でないと登録できない' do
        @user.family_name_spell = 'やまなし'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name spell Full-width katakana characters")
      end

      it 'first_name_spellが空だと登録できない' do
        @user.first_name_spell = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name spell can't be blank")
      end

      it 'first_name_spellが全角（カタカナ）でないと登録できない' do
        @user.first_name_spell = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name spell Full-width katakana characters")

      end

      it 'birth_dateが空だと登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
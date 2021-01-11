require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#create" do
    before do
      @user = FactoryBot.build(:user)
    end

    context "新規登録できる時" do
      it "email, password, password_confirmation, nickname, job_id, drink_coffee_idが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context "新規登録できない時" do 
      it "nicknameが空だと登録できない" do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it "emailが空だと登録できない" do 
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "emailに@がないと登録できない" do 
        @user.email = "jjjaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "emailが重複していると登録できない" do 
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it "passwordが空だと登録できない" do 
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "passwordが5文字以下だと登録できない" do
        @user.password = "aaa12"
        @user.password_confirmation = "aaa12"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it "passwordに半角数字が最低1文字入力されていないと登録できない" do
        @user.password = "aaaaaa"
        @user.password_confirmation = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めてください')
      end

      it "passwordに半角英字が最低1文字入力されていないと登録できない" do
        @user.password = "123456"
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めてください')
      end

      it "passwordとpassword_confirmationが異なると登録できない" do 
        @user.password = "aaa111"
        @user.password_confirmation = "111aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "job_idが空だと登録できない" do 
        @user.job_id = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Job を選択してください")
      end

      it "job_idが1だと登録できない" do 
        @user.job_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("Job を選択してください")
      end

      it "drink_coffee_idが空だと登録できない" do 
        @user.drink_coffee_id = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Drink coffee を選択してください")
      end

      it "drink_coffee_idが1だと登録できない" do
        @user.drink_coffee_id = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Drink coffee を選択してください")
      end
    end
  end
end

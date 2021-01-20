require 'rails_helper'

RSpec.describe "新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context "ユーザー新規登録ができる時" do
    it "正しい情報を入力すれば、新規登録できる" do
      #トップページに遷移する
      visit root_path
      #ヘッダーに新規登録ボタンがある。
      expect(page).to have_content("新規登録")
      #新規登録ページに遷移する
      visit new_user_registration_path
      #必要な事項を入力する
      fill_in "Email", with: @user.email
      select "コーヒー大好きだけど、これから業界で働く予定", from: "ご職業"
      fill_in "パスワード", with: @user.password
      fill_in "確認用パスワード", with: @user.password_confirmation
      fill_in "ニックネーム", with: @user.nickname
      select "1杯", from: "1日のコーヒー摂取量は？"
      #登録ボタンを押すと、モデルのカウントが１上がる
      expect{find('input[name="commit"]').click}.to change { User.count }.by(1)
      #登録が完了すると、トップページに遷移する
      expect(current_path).to eq root_path
      #ページにログアウトボタンと、「ようこそ、ユーザー名さん」ボタンがある
      expect(page).to have_content("ログアウト")
      expect(page).to have_content("ようこそ、#{@user.nickname}さん")
      #ページに、新規登録、ログインボタンがないことを確認する
      expect(page).to have_no_content("新規登録")
      expect(page).to have_no_content("ログイン")
    end
  end

  context "ユーザー新規登録ができない時" do
    it "誤った情報では、ユーザー新規登録ができず、エラーメッセージが表示された形で新規登録画面に遷移する" do
      #トップページに遷移する
      visit root_path
      #ヘッダーに新規登録ボタンがある。
      expect(page).to have_content("新規登録")
      #新規登録ページに遷移する
      visit new_user_registration_path
      #必要な事項を入力する
      fill_in "Email", with: ""
      select "--", from: "ご職業"
      fill_in "パスワード", with: ""
      fill_in "確認用パスワード", with: ""
      fill_in "ニックネーム", with: ""
      select "--", from: "1日のコーヒー摂取量は？"
      #登録ボタンを押すと、モデルのカウントは上がらない
      expect{find('input[name="commit"]').click}.to change { User.count }.by(0)
      #登録に失敗し、新規登録画面に遷移する
      expect(current_path).to eq "/users"
    end
  end
end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context "ログインできる時" do
    it "保存されたユーザー情報に合致している場合ログインできる" do
      #トップページに遷移する
      visit root_path
      #ヘッダーにログインボタンがある
      expect(page).to have_content("ログイン")
      #ログインページに遷移する
      visit new_user_session_path
      #必要事項を入力する
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      #ログインボタンを押す
      find('input[name="commit"]').click 
      #ログインに成功するとトップページに遷移する
      expect(current_path).to eq root_path
      #ページにログアウトボタンとユーザー名が入った「ようこそ、ユーザー名さん」ボタンがある
      expect(page).to have_content("ログアウト")
      expect(page).to have_content("ようこそ、#{@user.nickname}さん")
      #ページに、新規登録、ログインボタンがないことを確認する
      expect(page).to have_no_content("新規登録")
      expect(page).to have_no_content("ログイン")
    end
  end
  context "ログインできない場合" do
    it "入力されたデータが、保存されたデータに一致していないと、ログインできない" do
      #トップページに遷移する
      visit root_path
      #ヘッダーにログインボタンがある
      expect(page).to have_content("ログイン")
      #ログインページに遷移する
      visit new_user_session_path
      #必要事項を入力する
      fill_in "Email", with: ""
      fill_in "Password", with: ""
      #ログインボタンを押す
      find('input[name="commit"]').click 
      #ログインに失敗し、ログインページに遷移する
      expect(current_path).to eq "/users/sign_in"
    end
  end
end




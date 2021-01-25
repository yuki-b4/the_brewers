require 'rails_helper'

RSpec.describe "記事投稿機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.build(:article_tag)
  end

  context "新規投稿できる場合" do
    it "ログインしているユーザーは、新規投稿できる" do
      #ログインに成功すると、トップページに遷移する
      sign_in(@user)
      #投稿するボタンが存在する
      expect(page).to have_content("投稿する")
      #新規投稿ページに遷移する
      visit new_article_path
      #必要な項目を入力する(statusは公開に設定する) 
      fill_in "タイトル", with: @article.title
      image_path = Rails.root.join("spec/fixtures/files/test_image.png") 
      attach_file("article[image]", image_path, make_visible: true)
      fill_in "コーヒーの詳細（必須）", with: @article.detail
      fill_in "淹れ方の詳細(必須）", with: @article.how_brew
      fill_in "なぜそうしたのか（参考にした記事など）（必須）", with: @article.why_brew
      fill_in "こだわりポイント", with: @article.commit
      fill_in "お味はいかがでしたか？（必須）", with: @article.taste
      fill_in "タグ", with: @article.name
      select "公開", from: "article[status]"
      #投稿するボタンを押すと、artcileのカウントが1上昇する
      expect { find('input[name="commit"]').click }.to change { Article.count }.by(1)
      #投稿が完了したら、「投稿が完了しました！」と表示されている。
      expect(page).to have_content("投稿が完了しました！")
      #投稿された画像が表示されている
      expect(page).to have_selector("img")
      #保存された投稿の情報が表示されている
      expect(page).to have_content(@article.title)
      expect(page).to have_content(@article.detail)
      expect(page).to have_content(@article.how_brew)
      expect(page).to have_content(@article.why_brew)
      expect(page).to have_content(@article.commit)
      expect(page).to have_content(@article.taste)
      expect(page).to have_content(@article.name)
    end
  end

  context "新規投稿できない場合" do
    it "ログインしていないと、投稿できない" do
      #新規投稿ページに遷移する
      visit new_article_path
      #ログインページに遷移する
      expect(current_path).to eq new_user_session_path
    end

    it "必要な情報が入力されていないと、投稿できない" do
      #ログインに成功すると、トップページに遷移する
      sign_in(@user)
      #投稿するボタンが存在する
      expect(page).to have_content("投稿する")
      #新規投稿ページに遷移する
      visit new_article_path
      #投稿するをクリックする
      expect { find('input[name="commit"]').click }.to change { Article.count }.by(0)
      #新規投稿ページに遷移する
      expect(current_path).to eq "/articles"
    end
  end
end

# RSpec.describe "記事編集機能", type: :system do
#   before do
#     #一人目のユーザーと投稿を作成
#     @user1 = FactoryBot.create(:user)
#     @article1 = FactoryBot.build(:article_tag, user_id: @user1.id, status: 1)
#     @article1.image = fixture_file_upload('/files/test_image.png')
#     @article1.save
#     #別のユーザーと投稿を作成
#     @user2 = FactoryBot.create(:user)
#     @article2 = FactoryBot.build(:article_tag, user_id: @user2.id, status: 1)
#     @article2.image = fixture_file_upload('/files/test_image.png')
#     @article2.save
#   end

#   context "記事情報を編集し、更新できる時" do
#     it "ログインしているユーザーは、自分の投稿を編集・更新できる" do
#       #ログインする
#       sign_in(@user1)
#       #投稿の詳細ページに遷移する
#       click_on "#{@article1.title}"
#       #投稿した記事に遷移する
#       expect(page).to have_content("#{@article1.title}")
#       expect(page).to have_content("by#{@user1.nickname}")
#       #詳細ページに、編集ボタンがあるのを確認する
#       expect(page).to have_content("編集")
#       #編集ページに遷移する
#       visit edit_article_path(@article1)
#       #画像以外の保存された情報が入力されていることを確認する
#       expect(find("#article_title").value).to eq @article1.title
#       #記事情報を編集
#       # fill_in "タイトル", with: "コーヒーの作りかた"
#       # image_path = Rails.root.join("spec/fixtures/files/test_image.png") 
#       # attach_file("article[image]", image_path, make_visible: true)
#       # fill_in "コーヒーの詳細（必須）", with: "編集します"
#       # fill_in "淹れ方の詳細(必須）", with: "これが編集した後の結果です"
#       # fill_in "なぜそうしたのか（参考にした記事など）（必須）", with: @article.why_brew
#       # fill_in "こだわりポイント", with: @article.commit
#       # fill_in "お味はいかがでしたか？（必須）", with: @article.taste
#       # fill_in "タグ", with: @article.name
#     end
#   end
# end


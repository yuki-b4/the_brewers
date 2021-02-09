require 'rails_helper'

RSpec.describe '記事投稿機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.build(:article_tag)
  end

  context '新規投稿できる場合' do
    it 'ログインしているユーザーは、新規投稿できる' do
      # ログインに成功すると、トップページに遷移する
      sign_in(@user)
      # 投稿するボタンが存在する
      expect(page).to have_content('投稿する')
      # 新規投稿ページに遷移する
      visit new_article_path
      # 必要な項目を入力する(statusは公開に設定する)
      fill_in 'タイトル', with: @article.title
      image_path = Rails.root.join('spec/fixtures/files/test_image.png')
      attach_file('article[image]', image_path, make_visible: true)
      fill_in 'コーヒーの詳細（必須）', with: @article.detail
      fill_in '淹れ方の詳細(必須）', with: @article.how_brew
      fill_in 'なぜそうしたのか（参考にした記事など）（必須）', with: @article.why_brew
      fill_in 'こだわりポイント', with: @article.commit
      fill_in 'お味はいかがでしたか？（必須）', with: @article.taste
      fill_in 'タグ (必須)', with: @article.name
      select '公開', from: 'article[status]'
      # 投稿するボタンを押すと、artcileのカウントが1上昇する
      expect { find('input[name="commit"]').click }.to change { Article.count }.by(1)
      # 投稿が完了したら、「投稿が完了しました！」と表示されている。
      expect(page).to have_content('投稿が完了しました！')
      # 投稿された画像が表示されている
      expect(page).to have_selector('img')
      # 保存された投稿の情報が表示されている
      expect(page).to have_content(@article.title)
      expect(page).to have_content(@article.detail)
      expect(page).to have_content(@article.how_brew)
      expect(page).to have_content(@article.why_brew)
      expect(page).to have_content(@article.commit)
      expect(page).to have_content(@article.taste)
      expect(page).to have_content(@article.name)
    end
  end

  context '新規投稿できない場合' do
    it 'ログインしていないと、投稿できない' do
      # 新規投稿ページに遷移する
      visit new_article_path
      # ログインページに遷移する
      expect(current_path).to eq new_user_session_path
    end

    it '必要な情報が入力されていないと、投稿できない' do
      # ログインに成功すると、トップページに遷移する
      sign_in(@user)
      # 投稿するボタンが存在する
      expect(page).to have_content('投稿する')
      # 新規投稿ページに遷移する
      visit new_article_path
      # 投稿するをクリックする
      expect { find('input[name="commit"]').click }.to change { Article.count }.by(0)
      # 新規投稿ページに遷移する
      expect(current_path).to eq '/articles'
    end
  end
end

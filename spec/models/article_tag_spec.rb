require 'rails_helper'

RSpec.describe ArticleTag, type: :model do
  describe '#create' do
    before do
      @article_tag = FactoryBot.build(:article_tag)
      @article_tag.image = fixture_file_upload('/files/test_image.png')
    end

    it 'title, detail, how_brew, why_brew, commit, tatse, name, user_idがあれば新規投稿できる' do
      expect(@article_tag).to be_valid
    end

    it 'titleが空だと登録できない' do
      @article_tag.title = nil
      @article_tag.valid?
      expect(@article_tag.errors.full_messages).to include("Title can't be blank")
    end

    it 'detailが空だと登録できない' do
      @article_tag.detail = nil
      @article_tag.valid?
      expect(@article_tag.errors.full_messages).to include("Detail can't be blank")
    end

    it 'how_brewが空だと登録できない' do
      @article_tag.how_brew = nil
      @article_tag.valid?
      expect(@article_tag.errors.full_messages).to include("How brew can't be blank")
    end

    it 'why_brewが空だと登録できない' do
      @article_tag.why_brew = nil
      @article_tag.valid?
      expect(@article_tag.errors.full_messages).to include("Why brew can't be blank")
    end

    it 'tasteが空だと登録できない' do
      @article_tag.taste = nil
      @article_tag.valid?
      expect(@article_tag.errors.full_messages).to include("Taste can't be blank")
    end

    it 'nameが空だと登録できない' do
      @article_tag.name = nil
      @article_tag.valid?
      expect(@article_tag.errors.full_messages).to include("Name can't be blank")
    end

    it 'user_idが空だと登録できない' do
      @article_tag.user_id = nil
      @article_tag.valid?
      expect(@article_tag.errors.full_messages).to include("User can't be blank")
    end
  end
end

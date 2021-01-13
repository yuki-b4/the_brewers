require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "#create" do
    before do
      @tag = FactoryBot.build(:tag)
    end

    it "tagが重複していると登録できない" do
      @tag.save
      another_tag = FactoryBot.build(:tag, name: @tag.name)
      another_tag.valid?
      expect(another_tag.errors.full_messages).to include("Name has already been taken")
    end
  end
end

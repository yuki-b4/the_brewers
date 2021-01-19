class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true, null: false
      t.references :article, foreign_key: true,  null: false
      t.timestamps
    end
  end
end
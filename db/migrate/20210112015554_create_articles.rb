class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :detail, null: false
      t.text :how_brew, null: false
      t.text :why_brew, null: false
      t.string :commit
      t.string :taste, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end

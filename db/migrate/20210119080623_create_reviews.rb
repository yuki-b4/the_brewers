class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string     :review,       null: false
      t.references :article,      foreign_key: true
      t.references :user,         foreign_key: true
      t.timestamps
    end
  end
end

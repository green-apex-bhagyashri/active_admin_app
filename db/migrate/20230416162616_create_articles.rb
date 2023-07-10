class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.datetime :published_at
      t.belongs_to :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end

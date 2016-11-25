class ArticleAddColumns < ActiveRecord::Migration[5.0]
  def change
    change_table :articles do |t|
      t.text :content
      t.string :author_id
    end
  end
end

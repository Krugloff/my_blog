class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title, limit: 256
      t.text   :body
      t.timestamps
    end
  end
end

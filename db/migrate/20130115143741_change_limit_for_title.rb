class ChangeLimitForTitle < ActiveRecord::Migration
  def up
    change_column :articles, :title, :string, limit: 42
    change_column :comments, :title, :string, limit: 42
  end

  def down
    change_column :articles, :title, :string, limit: 256
    change_column :comments, :title, :string, limit: 256
  end
end

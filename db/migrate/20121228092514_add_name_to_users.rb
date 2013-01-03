class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, limit: 42
  end
end

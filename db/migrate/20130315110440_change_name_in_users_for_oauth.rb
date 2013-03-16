class ChangeNameInUsersForOauth < ActiveRecord::Migration
  def up
    change_table :users do |table|
      table.remove :name, :string
      table.column :name, :string
      table.remove_index(:name) if table.index_exists?(:name)
      table.index :name
    end
  end

  def down
    change_table :users do |table|
      table.change :name, :string, limit: 42
      table.remove_index :name
      table.index :name, name: "index_users_on_name", :unique => true
    end
  end
end

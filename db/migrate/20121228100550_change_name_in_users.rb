class ChangeNameInUsers < ActiveRecord::Migration
  def up
    change_table :users do |table|
      table.change :name, :string, null: false, limit: 42
    end
  end

  def down
    change_table :users do |table|
      table.change :name, :string, limit: 42
    end
  end
end

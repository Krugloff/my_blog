class LimitColumn < ActiveRecord::Migration
  def up
    change_table :articles do |table|
      table.change :title, :string, null: false, limit: 256
      table.change :body, :text, null: false      
    end
  end

  def down
    change_table :articles do |table|
      table.change :title, :string, null: true, limit: false
      table.change :body, :text, null: true   
    end
  end
end

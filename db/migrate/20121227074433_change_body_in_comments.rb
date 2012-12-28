class ChangeBodyInComments < ActiveRecord::Migration
  def up
    change_table :comments do |table|
      table.change :body, :text, null: false      
    end
  end

  def down
    change_table :comments do |table|
      table.change :body, :text, null: true      
    end
  end
end

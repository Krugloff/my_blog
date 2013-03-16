class AddUidToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :uid, :integer
    add_index :accounts, :uid
  end
end

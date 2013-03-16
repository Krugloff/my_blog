class AddUidToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :uid, :string
    add_index :accounts, :uid
  end
end

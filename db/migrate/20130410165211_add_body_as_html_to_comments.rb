class AddBodyAsHtmlToComments < ActiveRecord::Migration
  def change
    add_column :comments, :body_as_html, :text
  end
end

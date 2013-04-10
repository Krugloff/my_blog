class AddBodyAsHtmlToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :body_as_html, :text
  end
end

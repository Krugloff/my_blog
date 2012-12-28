class Comment < ActiveRecord::Base
  attr_accessible :title, :body

  # before_save :body_to_html

  belongs_to :article

  validates_presence_of :body, :article
  validates_length_of :title, maximum: 256

  private

  def body_to_html
    # Redcarpet.handle body
  end
end

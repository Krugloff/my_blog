module CommentsHelper
  def nested_comments_for( comment, from: [] )
    from.select { |nested| nested.parent_id == comment.id }
  end
end

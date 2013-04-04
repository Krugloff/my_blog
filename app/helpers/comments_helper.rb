module CommentsHelper
  def nested_comments_for( comment, from: nil )
    return [] if from.nil?
    nested, rest = from.partition { |nested| nested.parent_id == comment.id }
    from.replace rest
    nested
  end
end

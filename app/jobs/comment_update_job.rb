class CommentUpdateJob < ApplicationJob
  queue_as :default
  include WillPaginate::ViewHelpers

  def perform(comment, current_user)
    ProductChannel.broadcast_to(comment.product_id,
      comment: render_comment(comment, current_user),
      average_rating: comment.product.average_rating,
      highest_rating_comment: comment.highest_rating,
      page_entries_info: render_page_entries(comment.product.comments))
  end

  private

  def render_comment(comment, current_user)
    CommentsController.render(partial: 'comments/comment', locals: { comment: comment, current_user: current_user })
  end

  def render_page_entries(comments)
    page_entries_info comments.paginate(page: 1, per_page: 5)
  end
end
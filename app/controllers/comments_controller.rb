class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :authorize_admin, only: [:destroy]
  
  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new(comment_params)
    @comment.user = current_user
    @user = current_user
    respond_to do |format|
      if @comment.save
        # ActionCable.server.broadcast 'product_channel', comment: @comment, average_rating: @comment.product.average_rating
        format.html { redirect_to @product, notice: 'Your review was created successfully.' }
        format.json { render :show, status: :created, location: @product }
        format.js
      else
        format.html { redirect_to @product, alert: 'Your review was not saved, did you remember to rate this product?' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    product = @comment.product
    @comment.destroy
    redirect_to product
  end
  
  private

  def comment_params
    params.require(:comment).permit(:user_id, :body, :rating)
  end

  def authorize_admin
    return unless !current_user.admin?
    redirect_to root_path, :alert => "Only admins can delete comments"
    end
end
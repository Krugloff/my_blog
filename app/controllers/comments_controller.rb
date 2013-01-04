#encoding: utf-8

class CommentsController < ApplicationController
  before_filter :search_user
  before_filter :search_your_comment,
    except: "create"

  def create
    comment = Comment.new(params[:comment])
    comment.article_id = params[:article_id]
    comment.user = @user

    flash[:errors] = comment.errors.full_messages unless comment.save
    _redirect
  end

  def update
    @comment.update_attributes( params[:comment] )
    _redirect
  end

  def destroy
    @comment.destroy
    _redirect
  end

  private

  def search_your_comment
    @comment = @user.comments.find( params[:id] )

    rescue ::ActiveRecord::RecordNotFound
      flash[:error] = "Вы не можете изменить этот комментарий."
      _redirect
  end

  def _redirect
    redirect_to article_path( params[:article_id] )
  end
end

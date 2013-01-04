#encoding: utf-8

class CommentsController < ApplicationController
  before_filter :login?
  before_filter :authorization,
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

  def authorization
    unless @comment = @user.comments.find_by_id( params[:id] )
      flash[:error] = "Вы не можете изменить этот комментарий"
      _redirect
    end
  end

  def _redirect
    redirect_to article_path( params[:article_id] )
  end
end

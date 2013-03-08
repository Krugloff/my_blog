#encoding: utf-8

class CommentsController < ApplicationController
  before_filter :require_user,
    except: "index"
  before_filter :require_owner,
    except: %w(create index)

  def index
    @article = Article.find( params[:article_id] )
    @comments = @article.comments

    _respond_to_xhr_with_change_history
  end

  def create
    @comment = Comment.new( params[:comment] )
    @article = @comment.article = Article.find( params[:article_id] )
    @comment.user = @user

    unless request.xhr?
      # create_comment_on_post
      _save_errors unless @comment.save
      _redirect
    else
      # create_comment_on_xhr
      if @comment.save
        template = escape_javascript render_to_string(@comment)
        script = "$('#comments_count').html('#{@article.comments.count}');"
      else
        template = escape_javascript render_to_string partial: 'layouts/alert',
          collection: @comment.errors.full_messages
        script = ""
      end
      script += <<-SCRIPT
        $('div.alert').remove();
        $('.new_comment').before('#{template}');
      SCRIPT
      render js: _js_function(script)
    end
  end

  def update
    _save_errors unless @comment.update_attributes( params[:comment] )
    _redirect
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { _redirect }
      format.js do
        @comments_count = @comment.article.comments.count
        @id = @comment.id
        render partial: 'delete_comment'
      end
    end
  end

  private

    def require_owner
      @comment = Comment.find( params[:id] )

      unless ( @user.owner? @comment ) || _me?
        flash.alert = ["You can't edit this comment"]
        _redirect
      end
    end

    def _redirect
      redirect_to article_comments_path( params[:article_id] )
    end

    def _save_errors
      flash.alert = @comment.errors.full_messages
    end
end

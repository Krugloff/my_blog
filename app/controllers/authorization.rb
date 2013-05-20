require_relative 'application_controller'
require_relative 'users_controller'
require_relative 'comments_controller'
require_relative 'articles_controller'

require 'cando'

class ApplicationController
  helper_method :me?

  private

    def require_user
      unless @user
        redirect_to new_session_path, alert: ['You should be login']
      end
    end

    def require_me
      redirect_to new_session_path, alert: ["You can't do it"] unless me?
    end

    def me?
      @user.try :me?
    end
end

class UsersController
  before_filter :require_user
end

class CommentsController
  before_filter :require_user,
    except: 'index'

  before_filter :require_owner,
    except: %i( create index new )

  before_filter :require_me,
    only: 'destroy'

  def require_owner
    @comment = Comment.find( params[:id] )

    unless ( @user.owner? @comment ) || me?
      flash.alert = ["You can't edit this comment"]
      _redirect
    end
  end
end

class ArticlesController
  before_filter :require_user,
    except: %i( show index last )

  before_filter :require_owner,
    only: %i( update destroy edit )

  before_filter :require_me,
    only: %i( create new )

  def require_owner
    @article = Article.find params[:id]

    unless ( @user.owner? @article ) || me?
      flash.alert = ["You can't edit this article"]
      redirect_to article_path params[:id]
    end
  end
end
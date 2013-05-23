ApplicationController.class_exec do
  rescue_from Cando::Errors::AccessDenied do |exc|
    path = if exc.type == :owner
      case controller_name
      when 'articles'; article_path params[:id]
      when 'comments'; article_comments_path params[:article_id]
      end
    else
      new_session_path
    end
    redirect_to path, alert: [exc.message]
  end
end

Cando.authorize(UsersController) do |auth|
  auth.for_client *%i(show destroy)
end

Cando.authorize(CommentsController) do |auth|
  auth.for_client *%i(create new)
  auth.for_owner :update
  auth.for_admin :destroy
end

Cando.authorize(ArticlesController) do |auth|
  auth.for_owner *%i(update destroy edit)
  auth.for_admin *%i(create new)
end
MyBlog::Application.routes.draw do
  root to: "articles#last"

  resource :user, except: %i(new create) do
    resources :accounts, :only => :destroy
  end

  resource :session, only: %i(create destroy new) do
    match ':provider/new', :action => 'create', :on => :collection
  end

  resources :articles do
    resources :comments, except: 'edit'
  end
end

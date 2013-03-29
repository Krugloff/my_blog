MyBlog::Application.routes.draw do
  root to: "articles#last"

  resource :user, only: %w( show destroy )

  resource( :session, only: [ :create, :destroy, :new ] ) do
    match ':provider/new', :action => 'create', :on => :collection
  end

  resources :articles do
    resources :comments, except: 'edit'
  end
end

Rails.application.routes.draw do

  devise_for :users
  scope "/admin" do
    resources :users #, only: [:index, :show, :edit]
  end

  resources :comments
  resources :blogs do
    get 'page/:page', action: :index, on: :collection
    resources :comments # Nested Route
  end
  resources :puzzles

  resources :reviews
  resources :articles
  resources :products do
    get 'page/:page', action: :index, on: :collection
    resources :reviews # Nested Route
  end

  get 'blog/:id', to: 'blogs#show', as: 'blog_show'

  get 'email_article/:id', to: 'articles#email_article', as: 'email_article'

  root 'page#home'

  get 'user', to: 'stores#index', as: 'user_root'

  get 'store', to: 'stores#index', as: 'store_index'

  get 'store/:id', to: 'stores#show', as: 'store_show'

  get 'contact_us', to: 'page#contact_us', as: 'contact_us'

  get 'preferences', to: 'page#preferences', as: 'preferences'

  #get 'blog', to: 'page#blog', as: 'blog'

  get 'login_old', to: 'page#login_old', as: 'login_old'

  get 'project', to: 'page#project', as: 'project'

  get 'calendar((/:month)/:year)', to: 'page#calendar', as: 'calendar'

  get 'generate_puzzle_pdf/:id', to: 'puzzles#generate_puzzle_pdf', as: 'puzzle_pdf'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

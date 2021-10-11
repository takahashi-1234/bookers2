Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:"homes#top"
  get 'home/about', to: 'homes#about'
  resources :books do
    resources :book_comments,only:[:create,:destroy]
    resource :favorites,only:[:create,:destroy]
  end
  resources :users ,only:[:edit,:update,:index,:show] do
    resource:relationship,only:[:create,:destroy]
    get 'followings' =>'relationships#followings' ,as:'followings'
    get 'followers' => 'relationships#followers' ,as:'followers'
  end

end

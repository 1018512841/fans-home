FansHome::Application.routes.draw do

  root 'static_page#index'
  post "tourist_posts/upload_image"
  post "tourist_posts/destroy_image"
  post "tourist_posts/tourist_city"

  get "users/logout"
  get "users/login"
  get "login" => "users#login"
  post "users/check_login"

  post "life_posts/display_life_item_picture"
  post "sessions/change_locale"
  post "users/user_list"
  post "users/destroy_users"
  resources :tourist_posts
  resources :users
  resources :life_posts do
    get :avatar, on: :member
  end

  get "detail" => 'static_page#detail'
  get "static_page/index"

end

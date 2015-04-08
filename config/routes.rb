FansHome::Application.routes.draw do

  resources :blogs

  get "users/index"
  namespace :admin do
    resources :panels
    resources :users
  end

  root 'static_page#index'
  get "static_page/test"
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
  get "static_page/admin"

  namespace :qiniu do
    get :video_up_token
    get :image_up_token
    get :audio_up_token
  end
end

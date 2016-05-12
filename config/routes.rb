Rails.application.routes.draw do

  require 'sidekiq/web'
  # require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  # API Routes
  constraints :subdomain => "api" do
    scope :module => "api", :as => "api" do

      api_version(
          module: "V1",
          header: { name: "Accept", value: "application/vnd.skreem+json; version=1" },
          defaults: { format: :json }
        ) do

          post "auth/facebook", to: 'influencers#create'
          post "auth/twitter", to: 'influencers_twitter#create'
      end

    end
  end

  match 'influencer' => 'influencer#index', :via => :get
  get '/' => 'influencer#index', as: 'root'

  get 'influencer/:id/post' => 'post#index', as: 'post_index'
  get 'influencer/:id/post/new' => 'post#new', as: 'post_new'
  get 'influencer/:id/post/:postid' => 'post#show', as: 'post_show'
  post 'influencer/:id/post/create' => 'post#create', as: 'post_create'


  get 'influencer/:id/twitter_post' => 'twitter_post#index', as: 'twitter_post_index'
  get 'influencer/:id/twitter_post/new' => 'twitter_post#new', as: 'twitter_post_new'
  get 'influencer/:id/twitter_post/:postid' => 'twitter_post#show', as: 'twitter_post_show'
  post 'influencer/:id/twitter_post/create' => 'twitter_post#create', as: 'twitter_post_create'

  get "auth/instagram", to: 'influencers_instagram#create'
  get 'influencer/:id/instagram_post' => 'instagram_post#index', as: 'instagram_post_index'
  get 'influencer/:id/instagram_post/:postid' => 'instagram_post#show', as: 'instagram_post_show'

  post 'test_upload' => 'engagement#create', as: 'test_upload'
  get 'engagements' => 'engagement#index', as: 'engagements'
end

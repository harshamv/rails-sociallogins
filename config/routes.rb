Rails.application.routes.draw do

  # API Routes
  constraints :subdomain => "api" do
    scope :module => "api", :as => "api" do

      api_version(
          module: "V1",
          header: { name: "Accept", value: "application/vnd.skreem+json; version=1" },
          defaults: { format: :json }
        ) do

          post "auth/facebook", to: 'influencers#create'
      end

    end
  end

  match 'influencer' => 'influencer#index', :via => :get
  get '/' => 'influencer#index', as: 'root'

  get 'influencer/:id/post' => 'post#index', as: 'post_index'
  get 'influencer/:id/post2/:postid' => 'post#show', as: 'post_show'
  get 'influencer/:id/post/new' => 'post#new', as: 'post_new'
  post 'influencer/:id/post/create' => 'post#create', as: 'post_create'

end

Rails.application.routes.draw do

  resources :users, only: [:index]

  namespace :api do
    api_version(
        module: "V1",
        header: { name: "Accept", value: "application/vnd.pinch+json; version=1" },
        defaults: { format: :json }
      ) do

        resources :users, only: [:create, :show] do
          resources :gigs, only: [:index]
        end
        resource :user, only: [:update]
        resources :gigs, only: [:create,:show,:destroy]
        resources :venues, only: [:index,:create]
        resources :gig_likes, only: [:create,:show,:destroy]
        resources :cities, only: [:index,:create,:show]
        resources :neighborhoods, only: [:index,:create,:show]
        resources :friendships, only: [:index, :create]
        resource :friendships, only: [:destroy]
        resources :requests, only: [:index,:create]
        resources :devices, only: [:create]
        patch "/devices", to: 'devices#update'

        post "friendships/accept", to: 'friendships#accept'
        get "friendships/pending", to: 'friendships#pending'

        get "gigs/:id/likes", to: 'gig_likes#users'
        post "gigs/:id/like", to: 'gig_likes#create'
        delete "gigs/:id/like", to: 'gig_likes#destroy'
        post "gigs/:id/is_liked", to: 'gig_likes#show'
        post "gigs/:id/toggle", to: 'gigs#change_is_active'
        get "category/:id/gigs", to: 'gigs#category'

        post "cities/:id", to: 'cities#show'
        post "neighborhoods/filter", to: 'neighborhoods#filter'
        get "cities/:id/neighborhoods", to: 'cities#neighborhoods'

        patch "/logout", to: 'users#logout'
        post "users/gigs"
        post "/user", to: 'users#update'
        post "/facebook_verification", to: 'users#facebook_verification'
        get "/search", to: 'gigs#search'
        # patch "/user", to: 'users#data'
        patch "/user/seller", to: 'users#seller'

        get "/requests/incoming", to: 'requests#incomming'
        get "/requests/outgoing", to: 'requests#outgoing'
        get "/requests/:id", to: 'requests#show'
        patch "/requests/:id", to: 'requests#update'
        post "/requests/:id/issue", to: 'issues#create'
        post "/requests/:id/messages", to: 'messages#create'
        get "/requests/:id/messages", to: 'messages#index'

        resources :stripe, only: [:create]
        post "/stripe/transfer"

        resources :buyer_accounts, only: [:index,:create,:show]
        resources :seller_accounts, only: [:index,:create,:show]
        get "/accounts", to: 'accounts#index'

        resources :charges, only: [:index,:create,:show]
        resources :withdraws, only: [:index,:create,:show]

        resources :recent_activities, only: [:index]

        resources :credits, only: [:index]

        resources :passwords, only: [:create]

        resources :reviews, only: [:index,:create,:show]

        resources :categories, only: [:index]

        resources :promo_codes, only: [:create]

        resources :bookmarks, only: [:index]
        post "gig/:id/bookmark", to: 'bookmarks#create'

        resources :cities_wants, only: [:index,:create]

        resources :images, only: [:create]

        resources :my_promo_codes, only: [:index,:create]

        get "/referral_code", to: 'referral_codes#show'

    end
  end
   get "gigs/:token", to: 'helps#show'
end

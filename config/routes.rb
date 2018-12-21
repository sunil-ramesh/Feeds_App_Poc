Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users do
        collection do
          post :flat_feeds
        end
        collection do
        	get :get_activities
        end
      end
    end
  end
end

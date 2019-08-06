Rails.application.routes.draw do
  defaults format: :json do
    namespace :v1 do
      resources :boards, only: [:index]

      scope :boards do
        scope ':public_token' do
          scope 'save' do
            post   ':saveable_token', to: 'saves#create'
            delete ':saveable_token', to: 'saves#destroy'
          end

          root to: 'boards#show'
        end
      end
    end

    # Status
    get 'status', to: 'status#index'
    root          to: 'status#index'
  end
end

Rails.application.routes.draw do

  scope '/api' do
    mount_devise_token_auth_for 'User', at: '/auth'
    resources :games, except: [:new, :edit]
    post '/games/accept/:id', to: 'games#accept'
  end
end

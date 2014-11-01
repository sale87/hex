Rails.application.routes.draw do

  scope '/api' do
    mount_devise_token_auth_for 'User', at: '/auth'
    resources :games, except: [:new, :edit]
    post '/games/accept/:id', to: 'games#accept'
    post '/games/resign/:id', to: 'games#resign'
  end
end

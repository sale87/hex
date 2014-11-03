Rails.application.routes.draw do

  scope '/api' do
    mount_devise_token_auth_for 'User', at: '/auth'
    resources :games, except: [:new, :edit]
    post '/games/:id/accept', to: 'games#accept'
    post '/games/:id/resign', to: 'games#resign'
  end
end

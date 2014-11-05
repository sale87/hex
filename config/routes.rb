Rails.application.routes.draw do

  scope '/api' do
    mount_devise_token_auth_for 'User', at: '/auth'
    resources :games, except: [:new, :edit], defaults: {format: :json}
    post '/games/accept/:id', to: 'games#accept', defaults: {format: :json}
    post '/games/resign/:id', to: 'games#resign', defaults: {format: :json}
  end
end

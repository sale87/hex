Rails.application.routes.draw do

  scope '/api' do
    mount_devise_token_auth_for 'User', at: '/auth'
    resources :games, except: [:new, :edit], defaults: {format: :json}
    post '/games/:id/accept', to: 'games#accept', defaults: {format: :json}
    post '/games/:id/resign', to: 'games#resign', defaults: {format: :json}
  end
end

Rails.application.routes.draw do
  resources :games, except: [:new, :edit]
  scope '/api' do
    mount_devise_token_auth_for 'User', at: '/auth'
  end
end

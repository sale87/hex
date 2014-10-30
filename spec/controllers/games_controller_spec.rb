require 'spec_helper'

describe GamesController, :type => :controller do
  include Devise::TestHelpers

  before(:each) do
    @user = FactoryGirl.create(:confirmed_user)
  end

  describe 'index' do
    it 'is public' do
      get :index, :format => :json
      expect(JSON.load(response.body)).to eq([])
    end

    it 'returns all games' do
      FactoryGirl.create(:game)
      get :index, :format => :json
      expect(JSON.load(response.body).size).to eq(1)
    end
  end

  describe 'show' do
    before(:each) do
      FactoryGirl.create(:game)
    end

    it 'is public' do
      get :show, id: 1, :format => :json
      expect(JSON.load(response.body)['id']).to eq(1)
    end
  end

  describe 'create' do
    it 'requires login' do
      post :create, {}, :format => :json
      expect(response.status).to eq(401)
    end

    it 'creates game' do
      sign_in @user
      post :create, game: {description: 'This is my game', time_per_move: 1}, :format => :json
      expect(response.status).to eq(201)
      body = JSON.load(response.body)
      expect(body['description']).to eq('This is my game')
      expect(body['time_per_move']).to eq(1)
      expect(body['creator_id']).to eq(1)
    end
  end
end

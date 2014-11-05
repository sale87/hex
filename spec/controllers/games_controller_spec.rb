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
      post :create, {description: 'This is my game', time_per_move: 1}, :format => :json
      expect(response.status).to eq(201)
      body = JSON.load(response.body)
      expect(body['description']).to eq('This is my game')
      expect(body['time_per_move']).to eq(1)
      expect(body['creator_id']).to eq(1)
    end
  end

  describe 'destroy' do
    before(:each) do
      @game = FactoryGirl.create(:game)
    end

    it 'requires login' do
      delete :destroy, id: @game.id
      expect(response.status).to eq(401)
    end

    it 'fails to delete accepted game' do
      sign_in @user
      game = FactoryGirl.create(:accepted_game)
      delete :destroy, id: game.id, :format => :json
      expect(response.status).to eq(400)
      expect(JSON.load(response.body)['message']).to eq('You cannot delete accepted game.')
    end

    it 'deletes only not accepted game' do
      sign_in @user
      delete :destroy, id: @game.id, :format => :json
      expect(response.status).to eq(204)
    end

    it 'fails to delete other user game' do
      other_user = FactoryGirl.create(:confirmed_user)
      sign_in other_user
      delete :destroy, id: @game.id, :format => :json
      expect(response.status).to eq(403)
    end
  end

  describe 'accept' do
    before(:each) do
      @game = FactoryGirl.create(:game)
      @other_user = FactoryGirl.create(:confirmed_user)
    end

    it 'requires login' do
      post :accept, id: @game.id
      expect(response.status).to eq(401)
    end

    it 'can\'t be accepted by user that created it' do
      sign_in @user
      post :accept, id: @game.id, :format => :json
      expect(response.status).to eq(400)
      expect(JSON.load(response.body)['message']).to eq('You cannot accept your own game.')
    end

    it 'accepts game' do
      sign_in @other_user
      post :accept, id: @game.id, :format => :json
      expect(response.status).to eq(201)
      body = JSON.load(response.body)
      expect(body['id']).to eq(@game.id)
      expect(body['accepted_at']).not_to be_nil
      expect(body['white_id']).not_to be_nil
      expect(body['black_id']).not_to be_nil
      expect(body['black_id']).not_to eq(body['white_id'])
    end

    it 'cannot accept already accepted game' do
      sign_in @other_user
      post :accept, id: @game.id, :format => :json

      post :accept, id: @game.id, :format => :json
      expect(response.status).to eq(400)
      expect(JSON.load(response.body)['message']).to eq('Game already accepted.')
    end
  end

  describe 'resign' do
    before(:each) do
      @game = FactoryGirl.create(:accepted_game)
      @other_user = FactoryGirl.create(:confirmed_user)
    end

    it 'requires login' do
      post :resign, id: @game.id
      expect(response.status).to eq(401)
    end

    it 'can be resigned only by players playing the game' do
      third_user = FactoryGirl.create(:confirmed_user)
      sign_in third_user

      post :resign, id: @game.id, :format => :json
      expect(response.status).to eq(403)
      expect(JSON.load(response.body)['message']).to eq('Cannot resign other people games.')
    end

    it 'resigns game and sets winner' do
      sign_in @other_user
      post :resign, id: @game.id, :format => :json
      expect(response.status).to eq(201)
      expect(JSON.load(response.body)['winner']).to eq(@user.id)
      expect(JSON.load(response.body)['resigned']).to eq(true)
    end

    it 'cannot resign already resigned game' do
      sign_in @other_user
      post :resign, id: @game.id, :format => :json

      post :resign, id: @game.id, :format => :json
      expect(response.status).to eq(400)
      expect(JSON.load(response.body)['message']).to eq('Game already resigned.')
    end
  end
end


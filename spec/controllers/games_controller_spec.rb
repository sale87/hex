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
end

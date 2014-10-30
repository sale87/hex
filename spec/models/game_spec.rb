require 'spec_helper'

describe Game do
  before do
    @game = Game.new(creator_id: 1)
  end

  subject { @game }

  it { should respond_to(:creator_id) }
  it { should respond_to(:black_id) }
  it { should respond_to(:white_id) }
  it { should respond_to(:accepted_at) }
  it { should respond_to(:description) }
  it { should respond_to(:time_per_move) }
  it { should respond_to(:winner) }
  it { should respond_to(:resigned) }

  it { should be_valid }

  describe 'without creator_id' do
    before { @game.creator_id = ''}
    it { should_not be_valid }
  end

  describe 'with creator_id' do
    before { @game.creator_id = 1}
    it { should be_valid }
  end

end

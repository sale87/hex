class GamesController < ApplicationController
  before_action :set_game, only: [:show, :accept, :destroy, :resign]
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @games = Game.all
    respond_with(@games)
  end

  def show
    respond_with(@game)
  end

  def create
    @game = Game.new(game_params)
    @game.creator_id = current_user.id
    @game.save
    respond_with(@game)
  end

  # def update
  #   @game.update(game_params)
  #   respond_with(@game)
  # end

  def destroy
    if @game.creator_id != current_user.id
      head :forbidden
      return
    end

    if @game.accepted_at.nil?
      @game.destroy
      respond_with(@game)
    else
      head :bad_request
    end
  end

  def accept

  end

  def resign

  end

  private
    def set_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:description, :time_per_move)
    end
end

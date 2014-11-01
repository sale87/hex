class GamesController < ApplicationController
  before_action :set_game, only: [:show, :accept, :destroy, :accept, :resign]
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
      render json: {message: 'You cannot delete accepted game.'}, status: :bad_request
    end
  end

  def accept
    c_id = @game.creator_id
    u_id = current_user.id
    if c_id == u_id
      render json: {message: 'You cannot accept your own game.'}, status: :bad_request
    else
      if @game.accepted_at.nil?
        @game.accepted_at = Time.now
        @game.white_id, @game.black_id = creator_black? ? [u_id, c_id] : [c_id, u_id]
        @game.save
        respond_with(@game)
      else
        render json: {message: 'Game already accepted.'}, status: :bad_request
      end
    end
  end

  def resign
    if @game.resigned
      render json: {message: 'Game already resigned.'}, status: :bad_request
    elsif @game.black_id == current_user.id
      winner_by_resignation(@game.white_id)
    elsif @game.white_id == current_user.id
      winner_by_resignation(@game.black_id)
    else
      render json: {message: 'Cannot resign other people games.'}, status: :forbidden
    end
  end

  def winner_by_resignation(winner)
    @game.winner = winner
    @game.resigned = true
    @game.save
    respond_with(@game)
  end

  private
  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:description, :time_per_move)
  end

  def creator_black?
    rand * 10 >= 5
  end
end

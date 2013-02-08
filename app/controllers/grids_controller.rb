class GridsController < ApplicationController

  def new
  end

  def create
    @grid = SmallWorld::Grid.generate(columns: 50, rows: 50)
    render json: @grid.to_json
  end

  def update
    @grid = SmallWorld::Grid.load params[:grid]
    @grid.move_visitor!
    render json: @grid.to_json
  end

end

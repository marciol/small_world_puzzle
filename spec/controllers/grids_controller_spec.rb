require 'spec_helper'

describe GridsController do

  let (:grid_map) { { to_visit: [[1, 1], [2, 2]], visited: [], visitor: [4, 5] } }

  describe 'GET new' do
    it 'has a 200 status code' do
      get :new
      expect(response.code).to eq('200')
    end

    it 'renders the grids/new template' do
      get :new
      expect(response).to render_template('grids/new')
    end
  end

  describe 'POST create' do

    let (:grid) { double.as_null_object }

    before { SmallWorld::Grid.stub(:generate) { grid } }

    it 'assigns @grid' do
      post :create
      expect(assigns(:grid)).to eq(grid)
    end

    context 'When rendering in rspec is allowed' do
      render_views

      it 'renders @grid as a json object' do
        grid.stub(:to_json) { grid_map }
        post :create
        expect(response.body).to eq(grid_map.to_json)
      end
    end
  end


  describe 'PUT update' do
    let (:grid) { double.as_null_object }

    before { SmallWorld::Grid.stub(:load) { grid } }

    it 'assigns @grid' do
      put :update, grid: grid_map
      expect(assigns(:grid)).to eq(grid) 
    end

    it 'calls the move_visitor! on @grid' do
      grid.should_receive(:move_visitor!)
      put :update, grid: grid_map
    end

    context 'When redering in rspec is allowed' do
      render_views

      it 'renders the updated object' do
        expected = grid_map.merge(visitor: [5, 6])
        grid.stub(:to_json) { expected }

        put :update, grid: expected
        expect(response.body).to eq(expected.to_json)
      end
    end
  end
end

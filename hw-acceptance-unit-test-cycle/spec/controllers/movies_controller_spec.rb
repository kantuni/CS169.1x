require 'rails_helper'

describe MoviesController do
  describe 'find movies with same director' do
    before :each do
      @star_wars = FactoryBot.create(:movie)
      @ready_player_one = FactoryBot.create(:movie, title: 'Ready Player One', director: 'Steven Spielberg')
      @the_terminal = FactoryBot.create(:movie, title: 'The Terminal', director: 'Steven Spielberg')
    end

    context 'when the specified movie has a director' do
      it 'makes similar movies available to the template' do
        get :similar, id: @ready_player_one
        expect(assigns(:movies)).to eq([@ready_player_one, @the_terminal])
      end

      it 'renders similar movies template' do
        get :similar, id: @ready_player_one
        expect(response).to render_template :similar
      end
    end

    context 'when the specified movie has no director' do
      it 'leaves a notice' do
        movie = FactoryBot.create(:movie, director: '')
        get :similar, id: movie
        expect(flash[:notice]).to eq "'#{movie.title}' has no director info"
      end

      it 'redirects to the home page' do
        movie = FactoryBot.create(:movie, director: '')
        get :similar, id: movie
        expect(response).to redirect_to movies_path
      end
    end
  end
end

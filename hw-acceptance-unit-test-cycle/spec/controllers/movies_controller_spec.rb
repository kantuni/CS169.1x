require 'rails_helper'

describe MoviesController do
  describe 'find movies with same director' do
    context 'with valid attributes' do
      it 'finds similar movies' do
        # expect(Movie).to receive(:similar_movies)
        # get similar_movie_path
      end

      it 'renders similar movies template' do
        get :similar, id: '1'
        expect(response).to render_template :similar
      end
    end

    context 'with invalid attributes' do
      it 'leaves a notice' do

      end

      it 'redirects to the home page' do
        # get movies_path
        # expect(response).to redirect_to movies_path
      end
    end
  end
end

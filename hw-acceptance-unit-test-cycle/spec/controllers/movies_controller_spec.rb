require 'rails_helper'

describe MoviesController do
  describe 'show all movies' do
    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'show a movie' do
    it 'assigns the requested movie to @movie' do
      movie = FactoryGirl.create(:movie)
      get :show, id: movie
      expect(assigns(:movie)).to eq movie
    end

    it 'renders the :show view' do
      movie = FactoryGirl.create(:movie)
      get :show, id: movie
      expect(response).to render_template :show
    end
  end

  describe 'show a form to create a new movie' do
    it 'renders the :new view' do
      movie = FactoryGirl.create(:movie)
      get :new, id: movie
      expect(response).to render_template :new
    end
  end

  describe 'create a movie' do
    it 'creates a new movie' do
      expect {
        post :create, movie: FactoryGirl.attributes_for(:movie)
      }.to change(Movie, :count).by(1)
    end

    it 'leaves a notice' do
      movie = FactoryGirl.create(:movie)
      post :create, movie: FactoryGirl.attributes_for(:movie)
      expect(flash[:notice]).to eq "#{movie.title} was successfully created."
    end

    it 'redirects to the home page' do
      post :create, movie: FactoryGirl.attributes_for(:movie)
      expect(response).to redirect_to movies_path
    end
  end

  describe 'show a form to update a movie' do
    it 'renders the :edit view' do
      movie = FactoryGirl.create(:movie)
      get :edit, id: movie
      expect(response).to render_template :edit
    end
  end

  describe 'update a movie' do
    before :each do
      @movie = FactoryGirl.create(:movie)
    end

    it 'assigns the requested movie to @movie' do
      put :update, id: @movie, movie: FactoryGirl.attributes_for(:movie)
      expect(assigns(:movie)).to eq @movie
    end

    it 'changes the title' do
      put :update, id: @movie, movie: FactoryGirl.attributes_for(:movie, title: 'foo')
      @movie.reload
      expect(@movie.title).to eq 'foo'
    end

    it 'changes the rating' do
      put :update, id: @movie, movie: FactoryGirl.attributes_for(:movie, rating: 'foo')
      @movie.reload
      expect(@movie.rating).to eq 'foo'
    end

    it 'changes the description' do
      put :update, id: @movie, movie: FactoryGirl.attributes_for(:movie, description: 'foo')
      @movie.reload
      expect(@movie.description).to eq 'foo'
    end

    it 'changes the release date' do
      put :update, id: @movie, movie: FactoryGirl.attributes_for(:movie, release_date: Date.new(2000, 1, 1))
      @movie.reload
      expect(@movie.release_date).to eq Date.new(2000, 1, 1)
    end

    it 'changes the director' do
      put :update, id: @movie, movie: FactoryGirl.attributes_for(:movie, director: 'foo')
      @movie.reload
      expect(@movie.director).to eq 'foo'
    end

    it 'redirects to the updated movie' do
      put :update, id: @movie, movie: FactoryGirl.attributes_for(:movie)
      expect(response).to redirect_to movie_path(@movie)
    end
  end

  describe 'delete a movie' do
    before :each do
      @movie = FactoryGirl.create(:movie)
    end

    it 'deletes the movie' do
      expect {
        delete :destroy, id: @movie
      }.to change(Movie, :count).by(-1)
    end

    it 'redirects to the home page' do
      delete :destroy, id: @movie
      expect(response).to redirect_to movies_path
    end
  end

  describe 'find movies with same director' do
    before :each do
      @the_shawshank_redemption = FactoryGirl.create(:movie)
      @ready_player_one = FactoryGirl.create(:movie, title: 'Ready Player One', director: 'Steven Spielberg')
      @the_terminal = FactoryGirl.create(:movie, title: 'The Terminal', director: 'Steven Spielberg')
    end

    context 'when the specified movie has a director' do
      it 'makes similar movies available to the template' do
        get :similar, id: @ready_player_one
        expect(assigns(:movies)).to contain_exactly @ready_player_one, @the_terminal
      end

      it 'renders the :similar view' do
        get :similar, id: @ready_player_one
        expect(response).to render_template :similar
      end
    end

    context 'when the specified movie has no director' do
      it 'leaves a notice' do
        movie = FactoryGirl.create(:movie, director: '')
        get :similar, id: movie
        expect(flash[:notice]).to eq "'#{movie.title}' has no director info"
      end

      it 'redirects to the home page' do
        movie = FactoryGirl.create(:movie, director: '')
        get :similar, id: movie
        expect(response).to redirect_to movies_path
      end
    end
  end
end

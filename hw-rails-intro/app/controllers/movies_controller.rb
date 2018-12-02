class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id]
    @movie = Movie.find(id)
  end

  def index
    sort_by = params[:sort_by] || session[:sort_by]
    order = { title: :asc } if sort_by == 'title'
    order = { release_date: :asc } if sort_by == 'release_date'

    @all_ratings = Movie.all_ratings
    @selected_ratings = params[:ratings] || session[:ratings] || @all_ratings.map { |rating| [rating, 1] }.to_h

    if params[:sort_by] != session[:sort_by] or params[:ratings] != session[:ratings]
      session[:sort_by] = sort_by
      session[:ratings] = @selected_ratings
      redirect_to sort_by: sort_by, ratings: @selected_ratings and return
    end

    @movies = Movie.where(rating: @selected_ratings.keys).order(order)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

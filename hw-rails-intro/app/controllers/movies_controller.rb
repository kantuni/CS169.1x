class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = all_ratings

    # Determine if we need a redirect to a RESTful route.
    redirect = false
    if !params.key?(:ratings) && session.key?(:ratings)
      redirect = true
      params[:ratings] = session[:ratings]
    end
    if !params.key?(:sort_by) && session.key?(:sort_by)
      redirect = true
      params[:sort_by] = session[:sort_by]
    end

    session[:ratings] = params[:ratings] if params.key?(:ratings) && params[:ratings].keys.present?
    session[:sort_by] = params[:sort_by] if params.key? :sort_by

    @movies = Movie.all
    @movies = @movies.where(rating: session[:ratings].keys) if session.key? :ratings
    @movies = @movies.order(session[:sort_by]) if session.key? :sort_by

    q = { ratings: params[:ratings], sort_by: params[:sort_by] }
    redirect_to movies_path + '?' + q.to_query if redirect
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

  def all_ratings
    Movie.group(:rating).pluck(:rating)
  end

end

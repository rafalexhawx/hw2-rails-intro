class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index
      @all_ratings = @ratings_chosen = ['G','PG','PG-13','R']
      @ratings_chosen = !params['ratings'].nil? ? params['ratings'].keys : session['ratings']
      session['ratings'] = @ratings_chosen
      
      @class_title, @class_date = '', ''
      if(!params.key?(:sort)) #sort not in request so no sorting done
        @movies = Movie.with_ratings(session['ratings'])
        session['sort'] = ''
      elsif(params[:sort] == 'title') #sort by title
      session['sort'] = params[:sort]
        @movies = Movie.with_ratings(session['ratings']).order('title')
        
        @class_title = 'hilite'
      elsif(params[:sort] == 'date') #sort by release_date
      session['sort'] = params[:sort]
        @movies = Movie.with_ratings(session['ratings']).order('release_date')
        
        @class_date = 'hilite'
      end
      
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
  
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
  end
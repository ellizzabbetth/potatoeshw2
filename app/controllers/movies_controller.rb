class MoviesController < ApplicationController

#before_filter :load_ratings

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end



 # def index
#@movies = Movie.order(params[:sort])
#@movies = @movies.where(:rating => params[:ratings].keys) if params##[:ratings].present?
#@sort = params[:sort]
#@all = (params[:ratings].present? ? params[:ratings] : [])

#def index
 #   @movies = Movie.scoped	
  #  @movies = @movies.order('title') if params['sort'] == 'title'
 
# end


def index
   logger.debug "NEW PARAMS IS **** #{params[:sort]}"
   if params[:commit] == 'Refresh'
	session[:ratings] = params[:ratings]
	
   elsif session[:ratings] != params[:ratings]
	#degugger
	redirect = true
 	params[:ratings] = session[:ratings]
   end

   if params[:sort]
	session[:sort] = params[:sort]
   elsif session[:sort]
	#debugger
        redirect = true
	params[:sort] = session[:sort]
   end
    
   #@ratings
   #@all_ratings = Movie.all_ratings

#he

   # @selected_ratings = params[:ratings] if params.has_key? 'ratings'
   # @sort = params[:sort] if params.has_key? 'sort'

    #session[:selected_ratings] = @selected_ratings if @selected_ratings
   # session[:sort] = @sort if @sort

  # if !@selected_ratings && !@sort && session[:selected_ratings]
#	@selected_ratings = session[:selected_ratings] unless @selected_ratings
 #        @sort = session[:sort] unless @sort
#	flash.keep
#	redirect_to movies_path({sort: @sort, ratings: @selected_ratings})
 # end

   @ratings, @sort = session[:ratings], session[:sort]
   if redirect
	#debugger
	redirect_to movies_path({:sort => @sort, :ratings => @ratings})
   elsif
#debugger
	columns = {'title' => 'title', 'release_date' => 'release_date'}
        if columns.has_key?(@sort)
	  query = Movie.order(columns[@sort])
	else
	  @sort = nil
	  query = Movie
	end

   @movies = @ratings.nil? ? query.all : query.find_all_by_rating(@ratings.map { |r| r[0] })
  #@ratings  
   @all_ratings = Movie.all_ratings
   end


#   @selected_ratings = []
 #  if !params[:ratings].nil? 
  #   params[:ratings].each_key do |key|
   #    @selected_ratings << key
  # end
  
 
 #  elsif
 #    @selected_ratings = @all_ratings
 #  end 


#  @movies = Movie.where(:rating => @selected_ratings)
  
   #if params[:sort] == 'title'
    #  @title_header = 'hilite'
    #  @movies = Movie.all(:order => "title ASC")

#   elsif params[:sort] == 'release_date'
 #     @release_date ='hilite'
  #    @movies = Movie.all(:order => "release_date ASC")
   #end

end



   

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  #private

  #def load_ratings
   # @all_ratings = Movie.all_ratings
  #end

end

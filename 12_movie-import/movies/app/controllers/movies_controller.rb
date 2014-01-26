class MoviesController < ApplicationController
	
	def index
		@movies = Movie.all
	end

	def new
		@movie = Movie.new
	end

	def create
		@movie = Movie.new(movie_params)
		@movie.save
		redirect_to @movie
	end

	def edit
		@movie = Movie.find(params[:id])
	end

	def show
		@movie = Movie.find(params[:id])
	end

	def update
		@movie = Movie.find(params[:id])
		if @movie.update(movie_params) 
			redirect_to @movie 
		else
		 render 'edit'
		end
	end

	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy

		redirect_to movies_path
	end

	def import
	end

# 	def results
# 		@search_str = params[:movie]
# 		result = Typheous.get("http://www.omdbapi.com/", :params => )
# 		@result = JSON.parse(result.body)['Search']
# 		@result.each do |movie|
# 			mov = ({title: movie['Title'], year: movie['Year'], imdbID: movie['IM']})
# 			mov = Movie.create(mov)
# 		end
# 		@result
# end


		#1. Add gem to gemfile
		#2. Bundle install
		#3. Restart erver

	private
	  def movie_params
	    params.require(:movie).permit(:title, :year, :imdbID, :plot, :poster)
	  end

end

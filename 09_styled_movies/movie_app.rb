require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'


def create_movies_table
  c = PGconn.new(:host => "localhost", :dbname => "test")
  c.exec %q{
  CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    title TEXT,
    year INTEGER,
    description TEXT,
    rating INTEGER
  );
  }
  c.close
end

def imdb_pull(search_key, search_val)

  result = Typhoeus.get("http://www.omdbapi.com/", :params => {search_key => search_val})
  JSON.parse(result.body)

end

get '/' do
  erb :index
end

post '/results' do
  @search_str = params[:movie]
  
  # pull all movie information into one hash
  @movies = imdb_pull(:s, @search_str)["Search"]

  @movies.each do |m|
    one_movie = imdb_pull(:i, m["imdbID"])
    m.merge!(one_movie) if m["imdbID"] == one_movie["imdbID"]
    m["Poster"] = "images/no-poster.jpg" if m["Poster"] == "N/A"
  end
  @movies = @movies.sort_by {|movie| movie["Year"]}.reverse
  erb :results
 
end

get '/poster/:imdb' do |imdb_id|
  
  @movie = imdb_pull(:i, imdb_id)
  erb :poster
  
end
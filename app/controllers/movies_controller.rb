class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.all.decorate
    respond_to do |format|
      format.html
      format.json {
        movies = {}
        movies['movies'] = @movies.map { |movie| { 'id': movie.id, 'title': movie.title } }
        if params['genres']
          genres, genre_names, genre_counts = [], {}, Hash.new(0)

          @movies.each do |movie|
            genre_counts[movie.genre.name] += 1
            genre_names[movie.genre_id] = movie.genre.name
          end

          genre_names.each do |id, genre|
            genres.push({'id': id, 'name': genre, 'total_count': genre_counts[genre]})
          end
          movies['genres'] = genres
        end
        render json: movies
      }
    end
  end

  def show
    @movie = Movie.find(params[:id]).decorate
    respond_to do |format|
      format.html
      format.json { render json: @movie }
    end
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_now
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end
end

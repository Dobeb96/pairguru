class MovieDecorator < Draper::Decorator
  delegate_all

  API_ENDPOINT = 'https://pairguru-api.herokuapp.com/'

  def cover
    title = movie.title.downcase.gsub(' ', '_')
    "#{API_ENDPOINT}#{title}.jpg"
  end
end

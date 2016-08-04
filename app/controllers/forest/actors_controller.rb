class Forest::ActorsController < ForestLiana::ApplicationController
  def top_movies
    movies = Actor
      .find(params['actor_id'])
      .movies
      .order('imdb_rating DESC')
      .limit(3)

    render json: serialize_models(movies, include: [], count: movies.count)
  end
end

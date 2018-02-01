class Forest::Actor
  include ForestLiana::Collection

  collection :Actor

  has_many :top_movies, type: ['String'], reference: 'Movie.id'
end

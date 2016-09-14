class Forest::Actor
  include ForestLiana::Collection

  collection :actors

  has_many :top_movies, type: ['string'], reference: 'movies.id'
end

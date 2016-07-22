class StatsController < ForestLiana::ApplicationController
  caches_action :movies_per_country, :avg_rentals_per_user,
                :customer_paid_vs_free

  def movies_per_country
    value = Movie
      .joins(:countries)
      .group('countries.name')
      .count
      .map {|country, count| { key: country, value: count }}

    stat = ForestLiana::Model::Stat.new({
      value: value
    })

    render json: serialize_model(stat)
  end

  def avg_rentals_per_user
    stat = ForestLiana::Model::Stat.new({
      value: Rental.count / Customer.count
    })

    render json: serialize_model(stat)
  end

  def customer_paid_vs_free
    stat = ForestLiana::Model::Stat.new({
      value: [{
        key: 'Paid',
        value: Customer.where.not(stripe_id: nil).count
      }, {
        key: 'Free',
        value: Customer.where(stripe_id: nil).count
      }]
    })

    render json: serialize_model(stat)
  end
end

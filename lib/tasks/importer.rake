require 'net/http'
require 'wikipedia'

namespace :importer do
  desc "IMDB Top 250"

  def import_movie(title)
    url = URI.parse(URI::escape("http://www.omdbapi.com/?t=#{title.strip}&plot=full&r=json"))
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http| http.request(req) }

    movie = JSON.parse(res.body)
    if movie['Error'].blank?
      puts movie['Title']
      Movie.create({
        imdb_id: movie['imdbID'],
        title: movie['Title'],
        year: movie['Year'],
        runtime: movie['Runtime'],
        genre: movie['Genre'].split(',').map(&:strip),
        released: movie['Released'],
        director: movie['Director'].split(',').map(&:strip),
        writer: movie['Writer'].split(',').map(&:strip),
        casts: movie['Actors'].split(',').map(&:strip),
        imdb_rating: movie['imdbRating'],
        imdb_votes: movie['imdbVotes'],
        poster_url: movie['Poster'],
        full_plot: movie['Plot'],
        language: movie['Language'],
        country: movie['Country'],
        awards: movie['Awards']
      })
    end
  end

  task top250: :environment do
    Movie.delete_all

    File.foreach('db/csv/movie-list.txt') do |title|
      import_movie(title)
    end

    File.foreach('db/csv/tv-show-list.txt') do |title|
      import_movie(title)
    end
  end

  task actor_images: :environment do
    ActorImage.delete_all

    Actor.all.each_with_index do |actor, index|
      puts "#{index} #{actor.name}"
      page = Wikipedia.find(actor.name)
      page.image_urls.each do |url|
        ActorImage.create(actor: actor, url: url)
      end
    end
  end

  task customers: :environment do
    (1..10000).each do
      Customer.create(firstname: Faker::Name.first_name,
                      lastname: Faker::Name.last_name,
                      email: Faker::Internet.email,
                      country: Faker::Address.country,
                      city: Faker::Address.city,
                      street_address: Faker::Address.street_address,
                      zip_code: Faker::Address.zip_code,
                      state: Faker::Address.state,
                      geoloc: "#{Faker::Address.latitude} #{Faker::Address.longitude}")
    end
  end

  task stripe: :environment do
    possible_cards = ['4242424242424242', '4012888888881881',
                     '4000056655665556', '5555555555554444',
                     '5200828282828210', '5105105105105100', '378282246310005',
                     '371449635398431', '6011111111111117', '6011000990139424',
                     '30569309025904', '38520000023237', '3530111333300000',
                     '3566002020360505']

    Customer.where(stripe_id: nil).each do |customer|
      stripe = Stripe::Customer.create(email: customer.email)
      customer.stripe_id = stripe.id
      customer.save

      stripe.sources.create(source: {
        object: 'card',
        exp_month: rand(1..12),
        exp_year: rand(2020..2030),
        number: possible_cards.sample
      })

      Rental.where(customer: customer).each do |rental|
        Stripe::Charge.create(
          amount: (rental.movie.price * 100).to_i,
          currency: 'usd',
          customer: customer.stripe_id,
          metadata: {
            title: rental.movie.title,
            date: rental.created_at
          }
        )
      end

      puts "#{customer.email} done"
    end
  end

  task intercom: :environment do
    intercom = Intercom::Client.new(app_id: ENV['INTERCOM_APP_ID'],
                                    api_key: ENV['INTERCOM_API_KEY'])
    user_agents = [
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9',
      'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2224.3 Safari/537.36',
      'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.2117.157 Safari/537.36',
      'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1',
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10; rv:33.0) Gecko/20100101 Firefox/33.0',
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A',
      'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5355d Safari/8536.25',
      'Mozilla/5.0 (Linux; U; Android 4.0.3; ko-kr; LG-L160L Build/IML74K) AppleWebkit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30',
      'Mozilla/5.0 (Linux; U; Android 2.3; en-us) AppleWebKit/999+ (KHTML, like Gecko) Safari/999.9',
      'Mozilla/5.0 (compatible; MSIE 9.0; Windows Phone OS 7.5; Trident/5.0; IEMobile/9.0)'
    ]

    Customer.where.not(stripe_id: nil).each do |customer|
      intercom_user = intercom.users.create(email: customer.email,
                            name: "#{customer.firstname} #{customer.lastname}",
                            last_seen_ip: Faker::Internet.public_ip_v4_address,
                            last_seen_user_agent: user_agents.sample)

      intercom.messages.create({
        :message_type => 'inapp',
        :body => "What's up :)",
        :from => {
          :type => 'admin',
          :id   => "312465"
        },
        :to => {
          :type => "user",
          :id   => intercom_user.id
        }
      })
    end
  end

  task rentals: :environment do
    (1..10000).each do
      movie = Movie.offset(rand(Movie.count)).first
      customer = Customer.offset(rand(Customer.count)).first

      date = Faker::Time.backward(1095)
      Rental.create(movie: movie, customer: customer,
                    created_at: date, updated_at: date)
    end
  end
end

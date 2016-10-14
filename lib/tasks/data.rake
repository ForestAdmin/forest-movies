namespace :movies do
  task :seed, [:day] => :environment do |t, args|
    nnn = rand(5..100)
    day = args[:day].try(:to_i) || 0

    Customer.order(created_at: :desc).limit(nnn).destroy_all

    (1..nnn).each do
      customer = Customer.create(firstname: Faker::Name.first_name,
                      lastname: Faker::Name.last_name,
                      password: Faker::Internet.password(8, 20),
                      email: Faker::Internet.email,
                      country: Faker::Address.country,
                      city: Faker::Address.city,
                      street_address: Faker::Address.street_address,
                      zip_code: Faker::Address.zip_code,
                      state: Faker::Address.state)

      (1..5).each do
        date = (Date.today + day + rand(01..23).hour + rand(0..60).minutes).to_datetime
        Rental.create(movie: Movie.limit(1).order("RANDOM()").first,
                      customer: customer,
                      created_at: date,
                      updated_at: date)
      end
    end
  end

end

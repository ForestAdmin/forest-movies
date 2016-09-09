ForestLiana.secret_key = ENV['FOREST_KEY']
ForestLiana.auth_key = 'KCzlh119AQ8OuTHoRxg0UQ'

ForestLiana.integrations = {
  stripe: {
    api_key: ENV['STRIPE_SECRET_KEY'],
    mapping: 'Customer.stripe_id'
  },
  intercom: {
    app_id: ENV['INTERCOM_APP_ID'],
    api_key: ENV['INTERCOM_API_KEY'],
    mapping: 'Customer'
  }
}

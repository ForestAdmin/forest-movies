ForestLiana.env_secret = Rails.application.secrets.forest_env_secret
ForestLiana.auth_secret = Rails.application.secrets.forest_auth_secret

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

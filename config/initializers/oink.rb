if Rails.env.development? || Rails.env.test?
  Rails.application.middleware.use( Oink::Middleware, :logger => Rails.logger )
  Rails.logger.info("Configuring oink middleware in #{Rails.env}")
else
  Rails.logger.info("Not configuring oink middleware in #{Rails.env}")
end

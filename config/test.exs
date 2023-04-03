import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sentry_notifier, NotifierWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "UXIboU8g8BckqUGk3MEx8+EJo+VCL/P8BaiW4TndrIMcaM55CJBaZR+PV9raIHbV",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

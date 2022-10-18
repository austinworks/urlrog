import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
# We don't run a server during test. If one is required,
# you can enable the server option below.
config :urlrog, UrlrogWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "g8ibzjEvbT2wXi52ob182BAZU5RfTFEsDEVakKrM8ZpM/L9425PGdLEu1Jr/1y37",
  server: false

# In test we don't send emails.
config :urlrog, Urlrog.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :chat, Chat.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "chat_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :chat, ChatWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "7CUN68tyMpTXHX6rz2oVXlQ2xM/CrhQnIqcD0p4kF9ISCYugTnvXamX6lMvRYFTd",
  server: true

config :chat, :sandbox, Ecto.Adapters.SQL.Sandbox

# In test we don't send emails.
config :chat, Chat.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime


#wallaby related settings
config :wallaby, driver: Wallaby.Chrome # default
config :wallaby, otp_app: :chat
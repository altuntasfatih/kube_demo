import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :kube_demo, KubeDemoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "iZThBBMpJ2Asip7e+dCPJxjL+kXlTqL+9Dsv+eT4dyvkRzADoMX2/fRvxPucoySi",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

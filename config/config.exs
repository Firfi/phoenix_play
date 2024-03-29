# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phoenix_play,
  ecto_repos: [PhoenixPlay.Repo]

# Configures the endpoint
config :phoenix_play, PhoenixPlay.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uGEYYmbXBEkNI+oRME6sO6KBopP8M0Ofqmoj5EZ5XffHKrac4QILmO8PbSFt6B7h",
  render_errors: [view: PhoenixPlay.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixPlay.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "PhoenixPlay",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: "TODO SECRET KEY IN ENV", # TODO
  serializer: PhoenixPlay.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
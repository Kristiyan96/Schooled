# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :messages,
  ecto_repos: [Messages.Repo]

# Configures the endpoint
config :messages, MessagesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KB2mBjq1nau3ua7zKQZ7fbI3aRCdpTX/11OxyKdbpufrvFi5OEzKcT0hrmQc/Jw4",
  render_errors: [view: MessagesWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Messages.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

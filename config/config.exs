# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :keycloak_testapp_ex,
  ecto_repos: [KeycloakTestappEx.Repo]

# Configures the endpoint
config :keycloak_testapp_ex, KeycloakTestappExWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: KeycloakTestappExWeb.ErrorHTML, json: KeycloakTestappExWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: KeycloakTestappEx.PubSub,
  live_view: [signing_salt: "90bRWdwT"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :keycloak_testapp_ex, KeycloakTestappEx.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: []
  # metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    keycloak: {
      Ueberauth.Strategy.Keycloak, [
        default_scope: "profile openid email",
        uid_field: :email
      ]
    }
  ]

config :ueberauth, Ueberauth.Strategy.Keycloak.OAuth,
  client_id: "testapp-ex",
  client_secret: System.get_env("KEYCLOAK_CLIENT_SECRET", "default-client-secret"),
  redirect_uri: System.get_env("KEYCLOAK_REDIRECT_URI", "default-redirect-url"),
  authorize_url: "https://auth.nowtech.io/realms/app1/protocol/openid-connect/auth",   # optional
  token_url: "https://auth.nowtech.io/realms/app1/protocol/openid-connect/token",      # optional
  userinfo_url: "https://auth.nowtech.io/realms/app1/protocol/openid-connect/userinfo" # optional

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

defmodule KeycloakTestappEx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      KeycloakTestappExWeb.Telemetry,
      # Start the Ecto repository
      KeycloakTestappEx.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: KeycloakTestappEx.PubSub},
      # Start Finch
      {Finch, name: KeycloakTestappEx.Finch},
      # Start the Endpoint (http/https)
      KeycloakTestappExWeb.Endpoint
      # Start a worker by calling: KeycloakTestappEx.Worker.start_link(arg)
      # {KeycloakTestappEx.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KeycloakTestappEx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KeycloakTestappExWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

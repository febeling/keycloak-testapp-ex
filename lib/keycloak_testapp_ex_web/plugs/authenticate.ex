defmodule KeycloakTestappExWeb.Plugs.Authenticate do
  use Phoenix.VerifiedRoutes, endpoint: KeycloakTestappExWeb.Endpoint, router: KeycloakTestappExWeb.Router
  import Phoenix.Controller
  import Plug.Conn
  require Logger

  def init(_opts), do: %{}

  def call(conn, _opts) do
    Logger.info("Enforcing authentication")

    if conn |> get_session(:current_user) do
      Logger.info("User is authenticated as: #{conn |> get_session(:current_user)}")
      conn
    else
      Logger.info("User unauthenticated, halting!")
      conn
      |> put_flash(:error, "Login required.")
      # TODO redirect to sign_in, and save this URL in sessions?
      |> redirect(to: ~p"/")
      |> halt()
    end
  end
end

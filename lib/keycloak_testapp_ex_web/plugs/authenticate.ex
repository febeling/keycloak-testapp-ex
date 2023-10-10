defmodule KeycloakTestappExWeb.Plugs.Authenticate do
  use Phoenix.VerifiedRoutes, endpoint: KeycloakTestappExWeb.Endpoint, router: KeycloakTestappExWeb.Router
  import Phoenix.Controller
  import Plug.Conn
  require Logger

  def init(_opts), do: %{}

  def call(conn, _opts) do
    Logger.info("Enforcing authentication")

    if conn |> get_session(:user_email) do
      Logger.info("User is authenticated as: #{conn |> get_session(:user_email)}")
      conn
    else
      Logger.info("User not authenticated")
      conn
      |> put_flash(:error, "Login required.")
      |> redirect(to: ~p"/")
      |> halt()
    end
  end
end

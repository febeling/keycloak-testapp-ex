defmodule KeycloakTestappExWeb.Plugs.SessionInfo do
  use Phoenix.VerifiedRoutes, endpoint: KeycloakTestappExWeb.Endpoint, router: KeycloakTestappExWeb.Router
  # import Phoenix.Controller
  import Plug.Conn
  require Logger

  def init(_opts), do: %{}

  def call(conn, _opts) do
    Logger.info("Building session info")

    authenticated_user = conn |> get_session(:user_email)

    if authenticated_user != nil && authenticated_user != "" do
      Logger.debug("setting user: #{authenticated_user}")
      conn |> assign(:authenticated_user, authenticated_user)
    else
      conn
    end
  end
end

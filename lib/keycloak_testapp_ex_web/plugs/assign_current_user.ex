defmodule KeycloakTestappExWeb.Plugs.AssignCurrentUser do
  use Phoenix.VerifiedRoutes, endpoint: KeycloakTestappExWeb.Endpoint, router: KeycloakTestappExWeb.Router
  import Plug.Conn
  require Logger

  # Load current user from session to assign

  def init(_opts), do: %{}

  def call(conn, _opts) do
    case conn |> get_session(:current_user) do
      current_user when is_nil(current_user) or current_user == "" ->
        Logger.debug("#{__MODULE__}: no authenticated user")
        conn
      current_user ->
        Logger.info("#{__MODULE__}: assigning user '#{current_user}'")
        conn |> assign(:current_user, current_user)
    end
  end
end

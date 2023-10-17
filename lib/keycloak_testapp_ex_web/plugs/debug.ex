defmodule KeycloakTestappExWeb.Plugs.Debug do
  use Phoenix.VerifiedRoutes, endpoint: KeycloakTestappExWeb.Endpoint, router: KeycloakTestappExWeb.Router
  require Logger

  def init(_opts), do: %{}

  def call(conn, _opts) do
    Logger.debug("#{__MODULE__}: Is this a live view? => #{Map.has_key?(conn.assigns, :live_view)}")
    Logger.debug("conn.assigns")
    Logger.debug(conn.assigns)
    Logger.debug("conn.path_params")
    Logger.debug(conn.path_params)

    conn
  end
end

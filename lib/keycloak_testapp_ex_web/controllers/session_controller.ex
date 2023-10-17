defmodule KeycloakTestappExWeb.SessionController do
  require Logger
  use KeycloakTestappExWeb, :controller

  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

  def new(conn, _params) do
    render(conn, :new)
  end

  def callback(%{assigns: %{ueberauth_failure: fails}} = conn, _params) do
    Logger.warning("Failed login, failure: #{fails}")

    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    Logger.info("Successful login, auth data successfully matched")

    conn
    |> put_flash(:info, "Successfully authenticated.")
    |> put_session(:current_user, auth.info.email)
    |> configure_session(renew: true)
    |> redirect(to: "/")
  end

  @spec destroy(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def destroy(conn, _params) do
    if get_session(conn, :current_user) != nil do
      conn
      |> delete_session(:current_user)
      |> put_flash(:info, "Logged out.")
      |> redirect(to: ~p"/users")
    else
      conn
      |> redirect(to: ~p"/users")
    end
  end
end

defmodule KeycloakTestappExWeb.SessionController do
  require Logger
  use KeycloakTestappExWeb, :controller

  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

  def new(conn, _params) do
    render(conn, :new)
  end

  @spec create(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def create(conn, _params) do
    Logger.info("options: #{conn |> Helpers.options()}")
    request_url = conn |> Helpers.request_url()
    Logger.info("request_url: #{request_url}")
    redirect(conn, external: request_url)
  end

  def callback(%{assigns: %{ueberauth_failure: fails}} = conn, params) do
    Logger.warning("Successful login, failure: #{fails}")
    Logger.debug("params: #{params}")

    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    Logger.info("Successful login, auth data: #{auth}")
    Logger.info("params: #{params}")

    conn
    |> put_flash(:info, "Successfully authenticated.")
    |> put_session(:current_user, auth)
    |> configure_session(renew: true)
    |> redirect(to: "/")
  end

  @spec destroy(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def destroy(conn, _params) do
    if get_session(conn, :user_email) != nil do
      conn
      |> delete_session(:user_email)
      |> put_flash(:info, "Logged out.")
      |> redirect(to: ~p"/users")
    else
      conn
      |> redirect(to: ~p"/users")
    end
  end
end

defmodule KeycloakTestappExWeb.SessionController do
  use KeycloakTestappExWeb, :controller

  def create(conn, _params) do
    if get_session(conn, :user_email) == nil do
      conn
      |> put_session(:user_email, "mail@florianebeling.com")
      |> put_flash(:info, "Logged in.")
      |> redirect(to: ~p"/users")
    else
      conn
      |> redirect(to: ~p"/users")
    end
  end

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

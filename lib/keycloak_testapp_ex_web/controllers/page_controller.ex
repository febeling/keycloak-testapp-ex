defmodule KeycloakTestappExWeb.PageController do
  use KeycloakTestappExWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end

defmodule KeycloakTestappExWeb.SessionHTML do
  use KeycloakTestappExWeb, :html

  def new(assigns) do
    ~H"""
    <.link href={~p"/auth/keycloak"} class="text-zinc-700 py-2 px-3 bg-zinc-100 hover:bg-zinc-200 rounded">
      Sign in with Keycloak OAuth
    </.link>
    """
  end
end

defmodule KeycloakTestappExWeb.MoreComponents do
  use Phoenix.Component
  # alias Phoenix.LiveView.JS

  attr :authenticated_user, :string
  def authenticated_user(assigns) do
    if assigns[:authenticated_user] != nil do
      ~H"""
      <div><%= @authenticated_user %></div>
      """
    else
      ~H"""
      <div>nicht angemeldet</div>
      """
    end
  end
end

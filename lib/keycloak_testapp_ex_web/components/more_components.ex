defmodule KeycloakTestappExWeb.MoreComponents do
  use Phoenix.Component
  # alias Phoenix.LiveView.JS

  def user_signed_in?(assigns) do
    assigns[:authenticated_user] != nil
  end

  attr :authenticated_user, :string, default: nil
  def authenticated_user(assigns) do
    ~H"""
    <div><%= @authenticated_user || "nicht angemeldet" %></div>
    """
  end
end

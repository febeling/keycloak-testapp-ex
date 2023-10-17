defmodule KeycloakTestappExWeb.MoreComponents do
  use Phoenix.Component
  # alias Phoenix.LiveView.JS

  def user_signed_in?(assigns) do
    assigns[:current_user] != nil
  end

  attr :current_user, :string, default: nil
  def current_user(assigns) do
    ~H"""
    <div><%= @current_user || "nicht angemeldet" %></div>
    """
  end
end

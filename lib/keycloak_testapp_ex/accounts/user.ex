defmodule KeycloakTestappEx.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :provider, :string
    field :uid, :string
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :uid, :provider, :email])
    |> validate_required([:name, :uid, :provider, :email])
  end
end

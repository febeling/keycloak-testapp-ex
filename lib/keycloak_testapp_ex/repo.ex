defmodule KeycloakTestappEx.Repo do
  use Ecto.Repo,
    otp_app: :keycloak_testapp_ex,
    adapter: Ecto.Adapters.Postgres
end

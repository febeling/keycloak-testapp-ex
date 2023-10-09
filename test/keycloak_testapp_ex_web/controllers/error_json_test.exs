defmodule KeycloakTestappExWeb.ErrorJSONTest do
  use KeycloakTestappExWeb.ConnCase, async: true

  test "renders 404" do
    assert KeycloakTestappExWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert KeycloakTestappExWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end

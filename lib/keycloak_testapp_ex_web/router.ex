defmodule KeycloakTestappExWeb.Router do
  use KeycloakTestappExWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {KeycloakTestappExWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    plug KeycloakTestappExWeb.Plugs.Debug
    plug KeycloakTestappExWeb.Plugs.SessionInfo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth", KeycloakTestappExWeb do
    pipe_through :browser

    post "/:provider", SessionController, :create
    post "/:provider/callback", SessionController, :callback
  end

  scope "/", KeycloakTestappExWeb do
    pipe_through :browser

    get "/sign_in", SessionController, :new
    delete "/sign_out", SessionController, :destroy

    get "/", PageController, :home
    resources "/posts", PostController
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", KeycloakTestappExWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:keycloak_testapp_ex, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: KeycloakTestappExWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end

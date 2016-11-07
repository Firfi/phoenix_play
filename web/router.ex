defmodule PhoenixPlay.Router do
  use PhoenixPlay.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  pipeline :require_login do
    plug Guardian.Plug.EnsureAuthenticated, handler: PhoenixPlay.GuardianErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :app_layout do
    plug :put_layout, {PhoenixPlay.LayoutView, :app}
  end

  pipeline :static_layout do
    plug :put_layout, {PhoenixPlay.LayoutView, :static}
  end

  scope "/", PhoenixPlay do
    pipe_through [:browser, :static_layout] # Use the default browser stack
    get "/", PageController, :index
  end

  scope "/app/login", PhoenixPlay do
    pipe_through [:browser, :browser_session, :app_layout]
    get "/", AppController, :index
  end

  scope "/app", PhoenixPlay do
    pipe_through [:browser, :browser_session, :api_auth, :require_login, :app_layout]
    get "/*path", AppController, :index
  end

  scope "/api", PhoenixPlay do
    pipe_through [:api]
    post "/signup", SessionController, :signup
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixPlay do
  #   pipe_through :api
  # end
end

defmodule PhoenixPlay.GuardianErrorHandler do
  import PhoenixPlay.Router.Helpers

  def unauthenticated(conn, _params) do
    conn
    |> Phoenix.Controller.put_flash(:error,
                                    "You must be logged in to access that page.")
    |> Phoenix.Controller.redirect(to: "/app/login")
  end
end

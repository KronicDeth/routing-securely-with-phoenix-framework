defmodule RoutingSecurelyWithPhoenixFramework.Router do
  use RoutingSecurelyWithPhoenixFramework.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RoutingSecurelyWithPhoenixFramework do
    pipe_through :browser # Use the default browser stack

    get "/registration", RegistrationController, :new
    post "/registration", RegistrationController, :create

    get "/", SessionController, :new
    post "/login", SessionController, :create
    get "/logout", SessionController, :delete

    get "/pages", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", RoutingSecurelyWithPhoenixFramework do
  #   pipe_through :api
  # end
end

defmodule RoutingSecurelyWithPhoenixFramework.PageController do
  use RoutingSecurelyWithPhoenixFramework.Web, :controller

  plug RoutingSecurelyWithPhoenixFramework.Plug.Authenticate

  def index(conn, _params) do
    render conn, "index.html"
  end
end

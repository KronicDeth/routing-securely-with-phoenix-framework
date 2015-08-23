defmodule RoutingSecurelyWithPhoenixFramework.PageController do
  use RoutingSecurelyWithPhoenixFramework.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

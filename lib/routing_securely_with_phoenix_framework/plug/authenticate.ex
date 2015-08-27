defmodule RoutingSecurelyWithPhoenixFramework.Plug.Authenticate do
  import RoutingSecurelyWithPhoenixFramework.Router.Helpers

  def init(opts), do: opts

  def call(conn, _opts) do
    case Plug.Conn.get_session(conn, :current_user) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, 'You need to be signed in to view this page')
        |> Phoenix.Controller.redirect(to: session_path(conn, :new))
        |> Plug.Conn.halt
      current_user ->
        Plug.Conn.assign(conn, :current_user, current_user)
    end
  end
end
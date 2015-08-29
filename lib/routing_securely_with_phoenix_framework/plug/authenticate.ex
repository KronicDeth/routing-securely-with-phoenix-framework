defmodule RoutingSecurelyWithPhoenixFramework.Plug.Authenticate do
  import RoutingSecurelyWithPhoenixFramework.Router.Helpers

  alias RoutingSecurelyWithPhoenixFramework.Repo
  alias RoutingSecurelyWithPhoenixFramework.User

  def init(opts), do: opts

  def call(conn, _opts) do
    assign_current_user(conn)
  end

  # Private Functions

  defp assign_current_user(conn = %Plug.Conn{}) do
    assign_current_user(conn, Plug.Conn.get_session(conn, :current_user_id))
  end
  defp assign_current_user(conn, id) when is_integer(id) do
    assign_current_user(conn, Repo.get(User, id))
  end
  defp assign_current_user(conn, user = %User{}) do
    Plug.Conn.assign(conn, :current_user, user)
  end
  defp assign_current_user(conn, _), do: redirect_to_sign_in(conn)

  defp redirect_to_sign_in(conn) do
    conn
    |> Phoenix.Controller.put_flash(
         :error,
         'You need to be signed in to view this page'
       )
    |> Phoenix.Controller.redirect(to: session_path(conn, :new))
    |> Plug.Conn.halt
  end
end
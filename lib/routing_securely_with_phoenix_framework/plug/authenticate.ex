defmodule RoutingSecurelyWithPhoenixFramework.Plug.Authenticate do
  import RoutingSecurelyWithPhoenixFramework.Router.Helpers

  alias RoutingSecurelyWithPhoenixFramework.Repo
  alias RoutingSecurelyWithPhoenixFramework.User

  def init(opts), do: opts

  def call(conn, _opts) do
    assign_current_user(conn)
  end

  @doc """
  Stores `user` in session so that `call` can retrieve it.
  """
  def put_session(conn, user) do
    conn
    |> Plug.Conn.put_session(:current_user_id, user.id)
    |> Plug.Conn.put_session(:current_user_session_token, user.session_token)
  end

  # Private Functions

  defp assign_current_user(conn = %Plug.Conn{}) do
    assign_current_user conn,
                        Plug.Conn.get_session(conn, :current_user_id),
                        Plug.Conn.get_session(conn, :current_user_session_token)
  end

  defp assign_current_user(conn, id, session_token)
       when is_integer(id) and is_binary(session_token) do
    assign_current_user conn,
                        Repo.get_by(User, id: id, session_token: session_token)
  end
  defp assign_current_user(conn, _, _), do: redirect_to_sign_in(conn)

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
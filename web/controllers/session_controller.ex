defmodule RoutingSecurelyWithPhoenixFramework.SessionController do
  use RoutingSecurelyWithPhoenixFramework.Web, :controller

  alias RoutingSecurelyWithPhoenixFramework.Plug.Authenticate
  alias RoutingSecurelyWithPhoenixFramework.User

  plug :scrub_params, "user" when action in [:create]

  # Actions

  def create(conn, %{"user" => user_params}) do
    if is_nil(user_params["name"]) do
      nil
    else
      Repo.get_by(User, name: user_params["name"])
    end
    |> sign_in(user_params["password"], conn)
  end

  def delete(conn, _) do
    delete_session(conn, :current_user_id)
    |> put_flash(:info, "You have been logged out")
    |> redirect(to: session_path(conn, :new))
  end

  def new(conn, _params) do
    render conn, changeset: User.changeset(%User{})
  end
  
  # Private Functions

  @sign_in_error "Name or password are incorrect."

  defp sign_in(user, _password, conn) when is_nil(user) do
    conn
    |> put_flash(:error, @sign_in_error)
    |> render "new.html", changeset: User.changeset(%User{})
  end

  defp sign_in(user, password, conn) when is_map(user) do
    if Comeonin.Bcrypt.checkpw(password, user.password_hash) do
      conn
      |> put_flash(:info, "You are now signed in.")
      |> Authenticate.put_session(user)
      |> redirect(to: page_path(conn, :index))
    else
      conn
      |> put_flash(:error, @sign_in_error)
      |> render "new.html", changeset: User.changeset(%User{})
    end
  end
end
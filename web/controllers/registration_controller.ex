defmodule RoutingSecurelyWithPhoenixFramework.RegistrationController do
  use RoutingSecurelyWithPhoenixFramework.Web, :controller

  alias RoutingSecurelyWithPhoenixFramework.User

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    if changeset.valid? do
      case changeset |> User.generate_password |> Repo.insert do
        {:ok, user} ->
          conn
          |> put_flash(:info, "Successfully registered and logged in")
          |> put_session(:current_user, user)
          |> redirect(to: page_path(conn, :index))
        {:error, changeset} ->
          render conn, "new.html", changeset: changeset
      end
    else
      render conn, "new.html", changeset: changeset
    end
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end
end
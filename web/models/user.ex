defmodule RoutingSecurelyWithPhoenixFramework.User do
  use RoutingSecurelyWithPhoenixFramework.Web, :model

  schema "users" do
    field :socket_token, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string

    timestamps
  end

  @minimum_password_length 16
  @optional_fields ~w()
  @required_fields ~w(name password password_confirmation)
  @socket_token_length 64

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:password, min: @minimum_password_length)
    |> validate_length(:password_confirmation, min: @minimum_password_length)
    |> validate_confirmation(:password)
    |> unique_constraint(:name)
  end

  @doc """
  Fills `changeset` with generated columns.
  """
  def full_changeset(changeset) do
    changeset
    |> generate_password
    |> generate_socket_token
  end

  @doc """
  Generates a password for the user changeset and stores it to the changeset as encrypted_password.
  """
  def generate_password(changeset) do
    put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(changeset.params["password"]))
  end

  @doc """
  Generates a channel token for the user changeset.
  """
  def generate_socket_token(changeset) do
    put_change(changeset, :socket_token, generate_secret(@socket_token_length))
  end

  # Private Functions

  @doc """
  Generates a random secret string of the given `length`
  """
  defp generate_secret(length) do
    :crypto.strong_rand_bytes(length) |> Base.encode64 |> binary_part(0, length)
  end
end

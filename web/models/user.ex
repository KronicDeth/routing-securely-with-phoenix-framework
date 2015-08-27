defmodule RoutingSecurelyWithPhoenixFramework.User do
  use RoutingSecurelyWithPhoenixFramework.Web, :model

  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string

    timestamps
  end

  @minimum_password_length 16
  @optional_fields ~w()
  @required_fields ~w(name password password_confirmation)

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
  Generates a password for the user changeset and stores it to the changeset as encrypted_password.
  """
  def generate_password(changeset) do
    put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(changeset.params["password"]))
  end
end

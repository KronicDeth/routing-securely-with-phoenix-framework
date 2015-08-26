defmodule RoutingSecurelyWithPhoenixFramework.UserTest do
  use RoutingSecurelyWithPhoenixFramework.ModelCase

  alias RoutingSecurelyWithPhoenixFramework.User

  @valid_attrs %{name: "some content", password_hash: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end

defmodule PhoenixPlay.UserTest do
  use PhoenixPlay.ModelCase

  alias PhoenixPlay.User

  @valid_attrs %{email: "igor@loskutoff.com"}
  @invalid_attrs %{email: "some content"}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end

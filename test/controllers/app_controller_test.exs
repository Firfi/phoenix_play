defmodule PhoenixPlay.AppControllerTest do
  use PhoenixPlay.ConnCase

  setup do

    %User{
      id: 123456,
      username: "lcp",
      encrypted_password: Comeonin.Bcrypt.hashpwsalt("password")
    } |> Repo.insert

    user = Repo.get(User, 123456)

    {:ok, jwt, full_claims} = Guardian.encode_and_sign(user)
    {:ok, %{user: user, jwt: jwt, claims: full_claims}}

  end

  test "GET /api with user signed in should return success status", %{jwt: jwt} do
    conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get("/api")
    assert html_response(conn, 404)
  end

  test "GET /app with user signed in should return success status", context do
    conn = guardian_login(context[:user])
      |> get("/app")

    assert html_response(conn, 200)
  end

  test "GET /app with no user signed in should redirect somewhere" do
    conn = get build_conn, "/app"

    assert html_response(conn, 302)
  end

end
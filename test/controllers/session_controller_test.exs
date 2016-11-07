defmodule PhoenixPlay.SessionControllerTest do
  use PhoenixPlay.ConnCase

  test "/api/signup" do

    conn = post build_conn(), "/api/signup", Poison.encode(%{user: %{email: "igor@loskutoff.com", password: "Secret"}})
    assert json_response(conn, 200) == %{
      "user_id" => "1"
    }

  end
end

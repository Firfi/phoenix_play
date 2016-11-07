defmodule PhoenixPlay.SessionController do
  use PhoenixPlay.Web, :controller
  require Logger

#  def logout(conn, _params) do
#    conn
#    |> Guardian.Plug.sign_out
#    |> put_flash(:info, "Logged out")
#    |> redirect(to: "/")
#  end

  def signup(conn, %{"user" => user_params}) do
    Logger.info user_params
    changeset = User.changeset(%User{}, user_params)
    conn
      |> put_status(200)
      |> json(%{user_id: "1"})
  end

#  def create(conn, %{"user" => user_params}) do
#    User.changeset(%User{}, user_params)
#    case  MyApp.Repo.insert changeset do
#      {:ok, changeset} ->
#        conn
#        |> put_flash(:info, "Your account was created")
#        |> redirect(to: "/")
#      {:error, changeset} ->
#        conn
#        |> put_flash(:info, "Unable to create account")
#        |> render("new.html", changeset: changeset)
#    end
#  end

  def login(conn, params) do
    case User.find_and_confirm_password(params) do
      {:ok, user} ->
         new_conn = Guardian.Plug.api_sign_in(conn, user)
         jwt = Guardian.Plug.current_token(new_conn)
         claims = Guardian.Plug.claims(new_conn)
         exp = Map.get(claims, "exp")

         new_conn
         |> put_resp_header("authorization", "Bearer #{jwt}")
         |> put_resp_header("x-expires", exp)
         |> render("success.json", user: user, jwt: jwt, exp: exp)
      {:error, changeset} ->
        conn
        |> put_status(401)
        |> render("error.json", message: "Could not login")
    end
  end

  def logout(conn, _params) do
    jwt = Guardian.Plug.current_token(conn)
    claims = Guardian.Plug.claims(conn)
    Guardian.revoke!(jwt, claims)
    render "logout.json"
  end

end
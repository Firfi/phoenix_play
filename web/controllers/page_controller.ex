defmodule PhoenixPlay.PageController do
  use PhoenixPlay.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

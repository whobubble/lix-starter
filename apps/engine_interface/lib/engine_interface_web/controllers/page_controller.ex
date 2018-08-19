defmodule EngineInterfaceWeb.PageController do
  use EngineInterfaceWeb, :controller

  alias Engine.CounterSupervisor

  def index(conn, _params) do
    Plug.Conn.send_file(conn, 200, Path.expand("./priv/static/dist/index.html"))
  end

  def test(conn, %{"name" => name, "count" => count}) do
    {:ok, _pid} = CounterSupervisor.start_counter(name, String.to_integer(count))

    conn
    |> put_flash(:info, "You entered the name: " <> name <> " and count of " <> count)
    |> render("index.html")
  end
end

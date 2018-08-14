defmodule EngineInterfaceWeb.PageController do
  use EngineInterfaceWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

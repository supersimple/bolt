defmodule BoltuiWeb.PageController do
  use BoltuiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", data: NetworkMonitor.Data.all() |> Enum.reverse())
  end
end

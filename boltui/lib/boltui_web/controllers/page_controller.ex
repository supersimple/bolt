defmodule BoltuiWeb.PageController do
  use BoltuiWeb, :controller

  def index(conn, _params) do
    data = Boltfirmware.Data.all() |> Enum.reverse()
    render(conn, "index.html", data: data)
  end
end

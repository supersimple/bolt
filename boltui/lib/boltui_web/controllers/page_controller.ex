defmodule BoltuiWeb.PageController do
  use BoltuiWeb, :controller

  def index(conn, _params) do
    # data = Boltfirmware.Data.all() |> Enum.reverse()
    data = [
      %{packet_loss: 0.0, time: 13.13343, timestamp: DateTime.utc_now()}
    ]

    render(conn, "index.html", data: data)
  end
end

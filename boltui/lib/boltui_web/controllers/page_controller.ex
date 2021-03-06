defmodule BoltuiWeb.PageController do
  use BoltuiWeb, :controller

  def index(conn, _params) do
    # data = Boltfirmware.Data.all() |> Enum.reverse()
    data = [
      %{packet_loss: 0.0, time: 5.2334, timestamp: "2021-03-05 05:19:30.310936Z"},
      %{packet_loss: 0.0, time: 5.2334, timestamp: "2021-03-05 05:19:30.310936Z"},
      %{packet_loss: 0.0, time: 5.2334, timestamp: "2021-03-05 05:19:30.310936Z"},
      %{packet_loss: 0.0, time: 5.2334, timestamp: "2021-03-05 05:19:30.310936Z"},
      %{packet_loss: 0.0, time: 5.2334, timestamp: "2021-03-05 05:19:30.310936Z"},
      %{packet_loss: 0.0, time: 5.2334, timestamp: "2021-03-05 05:19:30.310936Z"},
      %{packet_loss: 0.0, time: 5.2334, timestamp: "2021-03-05 05:19:30.310936Z"},
      %{packet_loss: 0.0, time: 5.2334, timestamp: "2021-03-05 05:19:30.310936Z"},
      %{packet_loss: 0.0, time: 5.2334, timestamp: "2021-03-05 05:19:30.310936Z"},
      %{packet_loss: 0.0, time: 5.2334, timestamp: "2021-03-05 05:19:30.310936Z"},
      %{packet_loss: 0.0, time: 5.2334, timestamp: "2021-03-05 05:19:30.310936Z"},
      %{packet_loss: 0.0, time: 5.2334, timestamp: "2021-03-05 05:19:30.310936Z"},
      %{packet_loss: 0.0, time: 5.2334, timestamp: "2021-03-05 05:19:30.310936Z"},
      %{packet_loss: 0.0, time: 5.2334, timestamp: "2021-03-05 05:19:30.310936Z"},
    ]
    render(conn, "index.html", data: data)
  end
end

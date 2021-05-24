defmodule BoltuiWeb.LineGraph do
  use Phoenix.LiveView

  @impl true
  def render(assigns) do
    ~L"""
    <div class="overflow-hidden pt-4">
    <svg viewBox="0 0 800 200" class="chart">
    <text x="0" y="170">10ms</text>
    <text x="0" y="130">20ms</text>
    <text x="0" y="90">30ms</text>
    <text x="0" y="50">40ms</text>
    <text x="0" y="10">50ms</text>
    <polyline fill="none" id="loss_graph" points="<%= @loss_points %>" />
    <polyline fill="none" id="ping_graph" points="<%= @ping_points %>" />
    </svg>
    </div>
    """
  end

  @impl true
  def mount(_params, session, socket) do
    schedule_work()
    Process.send(self(), :work, [])

    {:ok,
     assign(socket,
       loss_points: [],
       ping_points: []
     )}
  end

  @impl true
  def handle_info(:work, socket) do
    schedule_work()

    data = Boltfirmware.Data.all() |> Enum.reverse()

    total_points = length(data)

    loss_points =
      data
      |> Enum.reverse()
      |> Enum.map(fn p -> points_to_graph({0, 100}, p.packet_loss) end)
      |> Enum.zip(x_axis_points(total_points))
      |> to_polyline_points()

    ping_points =
      data
      |> Enum.reverse()
      |> Enum.map(fn p -> points_to_graph({0, 50}, p.time) end)
      |> Enum.zip(x_axis_points(total_points))
      |> to_polyline_points()

    {:noreply,
     assign(socket,
       loss_points: loss_points,
       ping_points: ping_points
     )}
  end

  def schedule_work() do
    Process.send_after(self(), :work, 5_000)
  end

  defp points_to_graph({min, max}, data) do
    px_per_point = 200 / (max - min)
    200 - (data |> Kernel.*(px_per_point) |> Float.round(3) |> Kernel.+(1))
  end

  defp x_axis_points(0), do: []

  defp x_axis_points(total_points) do
    # width / points captured
    px_per_point = Float.round(800 / total_points, 2)
    Enum.map(0..total_points, &Kernel.*(&1, px_per_point))
  end

  defp to_polyline_points(list) do
    Enum.reduce(list, "", fn {y, x}, acc -> acc <> "#{x}, #{y} " end)
  end

end

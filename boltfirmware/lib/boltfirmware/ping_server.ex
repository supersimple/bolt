defmodule Boltfirmware.PingServer do
  @moduledoc """
  Genserver that pings teh internets on interval to verify a connection.
  """

  use GenServer

  alias Boltfirmware.{Data, Display, Power}

  @ping_interval Application.fetch_env!(:boltfirmware, :ping_interval)
  @pattern ~r/(?<time>[\d\.]+) ms \([\d\.]+ avg, (?<loss>[\d\.]+)%/

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    :timer.send_interval(@ping_interval, :ping)
    {:ok, %{}}
  end

  def handle_info(:ping, _state) do
    {response, _exit_code} = System.cmd("fping", ["-s", "-C", "3", "8.8.8.8"])

    response
    |> parse_response()
    |> calculate_results()
    |> write_display()
    |> store_data()
    |> maybe_restart()

    {:noreply, {}}
  end

  # response is a tuple when connection is made
  # empty string, response code 2 when endpoint not found
  # or network is down
  defp parse_response(""), do: {:error, :network_down}

  defp parse_response(response) do
    response
    |> String.split("\n", trim: true)
    |> Enum.map(&ping_summary/1)
    |> Enum.reject(&is_nil(&1))
  end

  defp ping_summary(line), do: Regex.named_captures(@pattern, line)

  defp calculate_results([]), do: {:error, :unknown_state}

  defp calculate_results(result_rows) do
    {total_packet_loss, total_time, number_of_rows} =
      Enum.reduce(result_rows, {0, 0, 0}, fn %{"loss" => loss, "time" => time}, {l, t, c} ->
        {String.to_integer(loss) + l, String.to_float(time) + t, c + 1}
      end)

    %{
      attempts: number_of_rows,
      packet_loss: total_packet_loss / number_of_rows,
      time: total_time / number_of_rows
    }
  end

  defp write_display(response) do
    Display.lightup(response)
    response
  end

  defp maybe_restart(response) do
    Power.maybe_restart(response)
    response
  end

  defp store_data(response) do
    data = Map.put(response, :timestamp, DateTime.utc_now())
    Data.put(data)
    response
  end
end

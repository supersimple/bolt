defmodule Boltfirmware.ResetServer do
  @moduledoc """
  Genserver that resets the router every 24 hours.
  """

  use GenServer

  alias Boltfirmware.Power

  @reset_interval Application.fetch_env!(:boltfirmware, :reset_interval)
  @target_time Application.fetch_env!(:boltfirmware, :reset_hour)

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    :timer.send_interval(@reset_interval, :check_time)
    {:ok, %{}}
  end

  def handle_info(:check_time, _state) do
    {_date, {hour, _min, _sec}} = :calendar.local_time()

    if hour == @target_time do
      Power.restart()
    end

    {:noreply, {}}
  end
end

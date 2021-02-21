defmodule Boltfirmware.Power do
  @moduledoc """
  Handles operations involved in power management.
  Assumes a single relay that is in the normally closed mode.
  """

  alias Boltfirmware.GPIO

  def maybe_restart(%{
        attempts: _attempts,
        packet_loss: 100,
        time: _time
      }) do
    cycle()
  end

  def maybe_restart(_attrs), do: :noop

  def restart, do: cycle()

  defp cycle do
    power_off()
    Process.sleep(15_000)
    power_on()
  end

  defp power_off do
    :relay_gpio
    |> GPIO.gpio()
    |> GPIO.write(1)
  end

  def power_on do
    IO.puts("Starting up")

    :relay_gpio
    |> GPIO.gpio()
    |> GPIO.write(0)
  end
end

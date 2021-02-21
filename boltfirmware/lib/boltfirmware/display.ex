defmodule Boltfirmware.Display do
  @moduledoc """
  Handles visual output of the application.
  """

  alias Boltfirmware.GPIO

  @doc """
  Expects a data structure from ping, and lights up the display according to that information.
  """
  def lightup(%{
        attempts: attempts,
        packet_loss: packet_loss,
        time: time
      }) do
    case status(attempts, packet_loss, time) do
      :alert -> do_alert()
      :warning -> do_warning()
      :unknown -> do_unknown()
      :ok -> do_ok()
    end
  end

  def lightup(_unknown_state), do: do_unknown()

  defp status(_attempts, 100, _time), do: :alert
  defp status(_attempts, packet_loss, _time) when packet_loss > 0, do: :warning
  defp status(_attempts, _packet_loss, time) when time > 2500, do: :warning
  defp status(0, _packet_loss, _wall_time), do: :unknown
  defp status(_attempts, _packet_loss, _wall_time), do: :ok

  defp do_alert do
    change_state(:red_gpio, 1)
    change_state(:yellow_gpio, 0)
    change_state(:green_gpio, 0)
  end

  defp do_warning do
    change_state(:red_gpio, 0)
    change_state(:yellow_gpio, 1)
    change_state(:green_gpio, 0)
  end

  defp do_ok do
    change_state(:red_gpio, 0)
    change_state(:yellow_gpio, 0)
    change_state(:green_gpio, 1)
  end

  defp do_unknown do
    change_state(:red_gpio, 1)
    change_state(:yellow_gpio, 1)
    change_state(:green_gpio, 1)
  end

  defp change_state(gpio_name, value) do
    gpio_name
    |> GPIO.gpio()
    |> GPIO.write(value)
  end
end

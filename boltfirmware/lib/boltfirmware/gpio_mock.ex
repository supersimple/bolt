defmodule Boltfirmware.GPIOMock do
  @moduledoc """
  Mocks the Circuits GPIO library
  """

  def open(pin_number, _pin_direction, _options \\ []) do
    {:ok, pin_number}
  end

  def write(pin_number, value) do
    IO.puts("Pin: #{pin_number} received state: #{value}")
  end
end

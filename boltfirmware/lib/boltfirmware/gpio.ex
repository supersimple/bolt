defmodule Boltfirmware.GPIO do
  @moduledoc """
  Manages GPIO setup and operations.
  """

  use GenServer

  @gpio_module Circuits.GPIO
  @red_pin Application.fetch_env!(:boltfirmware, :red_pin)
  @yellow_pin Application.fetch_env!(:boltfirmware, :yellow_pin)
  @green_pin Application.fetch_env!(:boltfirmware, :green_pin)
  @relay_pin Application.fetch_env!(:boltfirmware, :relay_pin)

  def init(_opts) do
    {:ok, red_gpio} = @gpio_module.open(@red_pin, :output, initial_value: 0)
    {:ok, yellow_gpio} = @gpio_module.open(@yellow_pin, :output, initial_value: 0)
    {:ok, green_gpio} = @gpio_module.open(@green_pin, :output, initial_value: 0)
    {:ok, relay_gpio} = @gpio_module.open(@relay_pin, :output, initial_value: 0)

    state = %{
      red_gpio: red_gpio,
      yellow_gpio: yellow_gpio,
      green_gpio: green_gpio,
      relay_gpio: relay_gpio
    }

    {:ok, state}
  end

  def handle_call(:state, _from, state), do: {:reply, state, state}

  # Public Interface #####################################

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def gpio(gpio_name) do
    __MODULE__
    |> GenServer.call(:state)
    |> Map.get(gpio_name)
  end

  def write(gpio, value) do
    @gpio_module.write(gpio, value)
  end
end

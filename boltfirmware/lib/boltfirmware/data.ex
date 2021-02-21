defmodule Boltfirmware.Data do
  @moduledoc """
  Stores ping data
  """

  use GenServer

  @max_size 2_880

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    {:ok, []}
  end

  def put(value) do
    GenServer.call(__MODULE__, {:put, value})
  end

  def all do
    GenServer.call(__MODULE__, {:get, :all})
  end

  def handle_call({:put, data}, _from, state) do
    # state has a max size
    state = if length(state) >= @max_size, do: List.delete_at(state, 0), else: state
    new_state = state ++ [data]
    {:reply, new_state, new_state}
  end

  def handle_call({:get, :all}, _from, state) do
    {:reply, state, state}
  end
end

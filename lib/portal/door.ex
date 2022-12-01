defmodule Portal.Door do
  @moduledoc """
  Module to store a state by implementing Agent.
  The state is FIFO queue.
  """
  use Agent

  @doc """
  Start the Agent with a given color instead of the Process ID.
  """
  def start_link(color) do
    Agent.start_link(fn -> [] end, name: color)
  end

  @doc """
  Returns the state of a door. The door is identified by it's color.
  """
  def get(color) do
    Agent.get(color, fn list -> list end)
  end

  @doc """
  Add a new item to a door. The door is identified by it's color.
  """
  def push(color, item) do
    Agent.update(color, fn list -> [item | list] end)
  end

  @doc """
  Pull the latest from a door. The door is identified by it's color.
  """
  def pop(color) do
    Agent.get_and_update(color, fn
      [] -> {:error}
      [head | tail] -> {{:ok, head}, tail}
    end)
  end
end

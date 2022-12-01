defmodule Portal do
  @enforce_keys [:left, :right]
  defstruct [:left, :right, total_transfers: 0]

  @doc """
  Starts transfering `data` from `left` to `right`.
  """
  def transfer(left, right, data) do
    # First add all data to the portal on the left
    for item <- data do
      Portal.Door.push(left, item)
    end

    # Returns a portal struct we will use next
    %Portal{left: left, right: right}
  end

  @doc """
  Pushes data to the right in the given `portal`.
  """
  def push_right(portal) do
    # See if we can pop data from left. If so, push the
    # popped data to the right. Otherwise, do nothing.
    case Portal.Door.pop(portal.left) do
      :error   -> :ok
      {:ok, h} -> Portal.Door.push(portal.right, h)
    end

    # Let's return the portal itself
    %Portal{portal | total_transfers: portal.total_transfers + 1}
  end

  @moduledoc """
  Shoots, aka creates, a new door with the given 'color'.
  """
  def shoot(color) do
    DynamicSupervisor.start_child(Portal.DoorSupervisor, {Portal.Door, color})
  end
end

defimpl Inspect, for: Portal do
  def inspect(%Portal{left: left, right: right, total_transfers: total_transfers}, _) do
    left_door = inspect(left)
    right_door = inspect(right)

    left_data = inspect(Enum.reverse(Portal.Door.get(left)))
    right_data = inspect(Portal.Door.get(right))

    max_padding = max(String.length(left_data), String.length(left_door))

    """
    % Portal
      #{String.pad_leading(left_door, max_padding)} <> #{right_door}
      #{String.pad_leading(left_data, max_padding)} <> #{right_data}
                #{total_transfers} Total Transfers
    """
  end
end

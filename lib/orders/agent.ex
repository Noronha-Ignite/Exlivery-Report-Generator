defmodule Exlivery.Orders.Agent do
  alias Exlivery.Orders.Order

  use Agent

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Order{} = order) do
    uuid = UUID.uuid4()

    Agent.update(__MODULE__, &update_order(&1, uuid, order))

    {:ok, uuid}
  end

  def list_all(), do: Agent.get(__MODULE__, & &1)

  def get(uuid), do: Agent.get(__MODULE__, &get_order(&1, uuid))

  defp update_order(current_map, uuid, %Order{} = order), do: Map.put(current_map, uuid, order)

  defp get_order(current_map, uuid) do
    case Map.get(current_map, uuid) do
      nil -> {:error, "Order not found"}
      order -> {:ok, order}
    end
  end
end

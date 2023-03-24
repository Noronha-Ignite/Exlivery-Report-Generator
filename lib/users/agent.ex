defmodule Exlivery.Users.Agent do
  alias Exlivery.Users.User

  use Agent

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user), do: Agent.update(__MODULE__, &update_user(&1, user))

  def get(cpf), do: Agent.get(__MODULE__, &get_user(&1, cpf))

  defp update_user(current_map, %User{cpf: cpf} = user), do: Map.put(current_map, cpf, user)

  defp get_user(current_map, cpf) do
    case Map.get(current_map, cpf) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end

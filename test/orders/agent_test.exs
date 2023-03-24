defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case

  alias Exlivery.Orders.Agent

  import Exlivery.Factory

  describe "save/1" do
    setup do
      Agent.start_link(%{})
      :ok
    end

    test "Should save the order" do
      order = build(:order)

      assert {:ok, _value} = Agent.save(order)
    end
  end

  describe "get/1" do
    setup do
      Agent.start_link(%{})
      :ok
    end

    test "when a order saved is found, returns the order" do
      {:ok, uuid} =
        :order
        |> build()
        |> Agent.save()

      response = Agent.get(uuid)

      assert response == {:ok, build(:order)}
    end

    test "when the uuid provided is not found, returns an error" do
      response = Agent.get("unexistent_uuid")

      assert response == {:error, "Order not found"}
    end
  end
end

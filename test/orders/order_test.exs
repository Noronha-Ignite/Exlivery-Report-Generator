defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  alias Exlivery.Orders.Order

  import Exlivery.Factory

  describe "build/2" do
    test "when all params are valid, returns the order" do
      user = build(:user)

      items = [
        build(:item),
        build(:item,
          description: "Chocolate",
          category: :sobremesa,
          quantity: 3,
          unit_price: Decimal.new("8.5")
        )
      ]

      response = Order.build(user, items)

      assert response == {
               :ok,
               build(:order)
             }
    end

    test "when there is no items, returns an error" do
      user = build(:user)

      response = Order.build(user, [])

      assert response == {:error, "Invalid parameters"}
    end
  end
end

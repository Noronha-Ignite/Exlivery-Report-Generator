defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case

  alias Exlivery.Orders.Item

  import Exlivery.Factory

  describe "build/4" do
    test "when all params are valid, returns the item" do
      response = Item.build("Pizza de brigadeiro", :pizza, "35.5", 1)

      assert response == {:ok, build(:item)}
    end

    test "when an invalid category is provided, returns an error" do
      response = Item.build("Pizza de brigadeiro", :not_existing_category, "35.5", 1)

      assert response == {:error, "Invalid parameters"}
    end

    test "when an invalid price is provided, returns an error" do
      response = Item.build("Pizza de brigadeiro", :pizza, "invalid_price", 1)

      assert response == {:error, "Invalid price"}
    end

    test "when an invalid quantity is provided, returns an error" do
      response = Item.build("Pizza de brigadeiro", :pizza, "35.5", -10)

      assert response == {:error, "Invalid parameters"}
    end
  end
end

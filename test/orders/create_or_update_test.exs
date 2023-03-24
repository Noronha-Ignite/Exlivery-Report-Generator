defmodule Exlivery.Orders.CreateOrUpdateOrderTest do
  use ExUnit.Case

  alias Exlivery.Orders.CreateOrUpdateOrder
  alias Exlivery.Users.Agent, as: UserAgent

  import Exlivery.Factory

  describe "call/1" do
    setup do
      Exlivery.start_agents()

      cpf = "12345678987"
      user = build(:user, cpf: cpf)

      UserAgent.save(user)

      item1 = build(:item, unit_price: Decimal.new("25.5"))
      item2 = build(:item, description: "Pizza de calabresa")

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "should save order when all params are valid", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [item1, item2]}

      response = CreateOrUpdateOrder.call(params)

      assert {:ok, _uuid} = response
    end

    test "should return error when the cpf given has no user match", %{item1: item1, item2: item2} do
      params = %{user_cpf: "invalid_cpf", items: [item1, item2]}

      response = CreateOrUpdateOrder.call(params)

      assert response == {:error, "User not found"}
    end

    test "should return error when there are invalid items given", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [%{item1 | quantity: 0}, item2]}

      response = CreateOrUpdateOrder.call(params)

      assert response == {:error, "Invalid items found"}
    end

    test "should return error when there are not items given", %{
      user_cpf: cpf
    } do
      params = %{user_cpf: cpf, items: []}

      response = CreateOrUpdateOrder.call(params)

      assert response == {:error, "Invalid parameters"}
    end
  end
end

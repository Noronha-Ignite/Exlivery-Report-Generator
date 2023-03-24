defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.{Item, Order}
  alias Exlivery.Users.User

  def user_factory do
    %User{
      name: "Noronha",
      email: "noronha@gabriel.com",
      cpf: "12345678987",
      age: 20,
      address: "Rua noronha"
    }
  end

  def item_factory do
    %Item{
      category: :pizza,
      description: "Pizza de brigadeiro",
      quantity: 1,
      unit_price: Decimal.new("35.5")
    }
  end

  def order_factory do
    items = [
      build(:item),
      build(:item,
        description: "Chocolate",
        category: :sobremesa,
        quantity: 3,
        unit_price: Decimal.new("8.5")
      )
    ]

    %Order{
      delivery_address: "Rua noronha",
      items: items,
      total_price: Decimal.new("61.00"),
      user_cpf: "12345678987"
    }
  end
end

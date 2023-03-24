defmodule Exlivery.Orders.Report do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Item
  alias Exlivery.Orders.Order

  def create(filename \\ "report.csv") do
    order_list = build_order_list()

    File.write(filename, order_list)
  end

  defp build_order_list() do
    OrderAgent.list_all()
    |> Map.values()
    |> Enum.map(&parse_order_string/1)
  end

  defp parse_order_string(%Order{user_cpf: cpf, items: items, total_price: total_price}) do
    itens_string = Enum.map(items, &parse_item_string/1)

    "#{cpf},#{itens_string},#{total_price}\n"
  end

  defp parse_item_string(%Item{description: description, quantity: quantity, unit_price: unit_price}) do
    "#{description},#{quantity},#{unit_price}"
  end
end

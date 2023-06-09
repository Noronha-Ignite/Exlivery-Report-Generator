defmodule Exlivery.Orders.Item do
  @categories [:pizza, :hamburguer, :carne, :prato_feito, :japonesa, :sobremesa]

  @keys [:description, :category, :unit_price, :quantity]

  @enforce_keys @keys
  defstruct @keys

  def build(description, category, unit_price, quantity)
      when quantity > 0 and category in @categories do
    unit_price
    |> Decimal.cast()
    |> build_item(description, category, quantity)
  end

  def build(_description, _category, _unit_price, _quanitity) do
    {:error, "Invalid parameters"}
  end

  defp build_item({:ok, unit_price}, desc, category, quantity) do
    {:ok,
     %__MODULE__{
       description: desc,
       category: category,
       unit_price: unit_price,
       quantity: quantity
     }}
  end

  defp build_item(:error, _desc, _category, _quantity) do
    {:error, "Invalid price"}
  end
end

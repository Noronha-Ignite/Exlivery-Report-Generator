defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    setup do
      OrderAgent.start_link(%{})

      :order |> build() |> OrderAgent.save()
      :order |> build() |> OrderAgent.save()

      :ok
    end

    test "creates the report when given valid params" do
      Report.create('report_test.csv')

      response = File.read!('report_test.csv')

      expected_response =
        "12345678987,Pizza de brigadeiro,1,35.5Chocolate,3,8.5,61.00\n" <>
          "12345678987,Pizza de brigadeiro,1,35.5Chocolate,3,8.5,61.00\n"

      assert response == expected_response
    end
  end
end

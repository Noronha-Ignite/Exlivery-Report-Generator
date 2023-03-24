defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent

  import Exlivery.Factory

  describe "save/1" do
    setup do
      Agent.start_link(%{})
      :ok
    end

    test "Should save the user" do
      user = build(:user)

      assert Agent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      Agent.start_link(%{})
      {:ok, cpf: "12345678987"}
    end

    test "when a cpf saved is found, returns the user", %{cpf: cpf} do
      :user
      |> build(cpf: cpf)
      |> Agent.save()

      response = Agent.get(cpf)

      assert response == {:ok, build(:user, cpf: cpf)}
    end

    test "when the cpf provided is not found, returns an error", %{cpf: cpf} do
      response = Agent.get(cpf)

      assert response == {:error, "User not found"}
    end
  end
end

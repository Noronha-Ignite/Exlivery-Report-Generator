defmodule Exlivery.Users.CreateOrUpdateUserTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent
  alias Exlivery.Users.CreateOrUpdateUser

  describe "call/1" do
    setup do
      Agent.start_link(%{})
      :ok
    end

    test "when all params are valid, saves the user" do
      response =
        CreateOrUpdateUser.call(%{
          name: "Noronha",
          address: "Rua Noronha",
          email: "noronha@email.com",
          cpf: "12345678987",
          age: 20
        })

      assert response == {:ok, "Operation succeed"}
    end

    test "when there are invalid params, returns an error" do
      response =
        CreateOrUpdateUser.call(%{
          name: "Noronha",
          address: "Rua Noronha",
          email: "noronha@email.com",
          cpf: "12345678987",
          age: 15
        })

      assert response == {:error, "Invalid data"}
    end
  end
end

defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "build/5" do
    test "when all params are valid, returns the user" do
      response = User.build("Noronha", "noronha@gabriel.com", "12345678987", 20, "Rua noronha")

      assert response ==
               {:ok, build(:user)}
    end

    test "when no valid params are provided, returns an error" do
      response = User.build("Noronha", "noronha@gabriel.com", "12345678987", -10, "Rua noronha")

      assert response == {:error, "Invalid data"}
    end
  end
end

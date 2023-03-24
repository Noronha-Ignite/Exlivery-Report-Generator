defmodule Exlivery.Users.CreateOrUpdateUser do
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  def call(%{name: name, address: address, email: email, cpf: cpf, age: age}) do
    user_response = User.build(name, email, cpf, age, address)

    save_user(user_response)
  end

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)

    {:ok, "Operation succeed"}
  end

  defp save_user({:error, message}), do: {:error, message}
end

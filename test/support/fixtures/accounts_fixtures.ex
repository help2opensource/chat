defmodule Chat.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Chat.Accounts` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        message: "some message",
        name: "some name"
      })
      |> Chat.Accounts.create_message()

    message
  end
end

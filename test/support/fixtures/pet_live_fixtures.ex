defmodule Chat.PetLiveFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Chat.PetLive` context.
  """

  @doc """
  Generate a pet.
  """
  def pet_fixture(attrs \\ %{}) do
    {:ok, pet} =
      attrs
      |> Enum.into(%{
        name: "some name",
        age: 42
      })
      |> Chat.PetLive.create_pet()

    pet
  end
end

defmodule Chat.PetLiveTest do
  use Chat.DataCase

  alias Chat.PetLive

  describe "pets" do
    alias Chat.PetLive.Pet

    import Chat.PetLiveFixtures

    @invalid_attrs %{name: nil, age: nil}

    test "list_pets/0 returns all pets" do
      pet = pet_fixture()
      assert PetLive.list_pets() == [pet]
    end

    test "get_pet!/1 returns the pet with given id" do
      pet = pet_fixture()
      assert PetLive.get_pet!(pet.id) == pet
    end

    test "create_pet/1 with valid data creates a pet" do
      valid_attrs = %{name: "some name", age: 42}

      assert {:ok, %Pet{} = pet} = PetLive.create_pet(valid_attrs)
      assert pet.name == "some name"
      assert pet.age == 42
    end

    test "create_pet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PetLive.create_pet(@invalid_attrs)
    end

    test "update_pet/2 with valid data updates the pet" do
      pet = pet_fixture()
      update_attrs = %{name: "some updated name", age: 43}

      assert {:ok, %Pet{} = pet} = PetLive.update_pet(pet, update_attrs)
      assert pet.name == "some updated name"
      assert pet.age == 43
    end

    test "update_pet/2 with invalid data returns error changeset" do
      pet = pet_fixture()
      assert {:error, %Ecto.Changeset{}} = PetLive.update_pet(pet, @invalid_attrs)
      assert pet == PetLive.get_pet!(pet.id)
    end

    test "delete_pet/1 deletes the pet" do
      pet = pet_fixture()
      assert {:ok, %Pet{}} = PetLive.delete_pet(pet)
      assert_raise Ecto.NoResultsError, fn -> PetLive.get_pet!(pet.id) end
    end

    test "change_pet/1 returns a pet changeset" do
      pet = pet_fixture()
      assert %Ecto.Changeset{} = PetLive.change_pet(pet)
    end
  end
end

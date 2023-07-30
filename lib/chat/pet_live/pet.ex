defmodule Chat.PetLive.Pet do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {
    Flop.Schema,
    filterable: [:name, :age],
    sortable: [:name, :age]
  }

  schema "pets" do
    field :name, :string
    field :age, :integer

    timestamps()
  end

  @doc false
  def changeset(pet, attrs) do
    pet
    |> cast(attrs, [:name, :age])
    |> validate_required([:name, :age])
  end
end

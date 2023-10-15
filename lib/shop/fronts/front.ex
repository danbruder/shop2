defmodule Shop.Fronts.Front do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fronts" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(front, attrs) do
    front
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

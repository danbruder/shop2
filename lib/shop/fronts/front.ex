defmodule Shop.Fronts.Front do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fronts" do
    field :name, :string
    field :subdomain, :string

    timestamps()
  end

  @doc false
  def changeset(front, attrs) do
    front
    |> cast(attrs, [:name, :subdomain])
    |> validate_required([:name, :subdomain])
  end
end

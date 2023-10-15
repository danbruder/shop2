defmodule Shop.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :description, :string
    field :title, :string
    field :price, :integer
    field :photo, :binary
    field :front_id, :id

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:title, :description, :price, :photo, :front_id])
    |> validate_required([:title, :description, :price, :front_id])
  end
end

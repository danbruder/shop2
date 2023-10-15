defmodule Shop.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string
      add :description, :string
      add :price, :integer
      add :photo, :binary
      add :front_id, references(:fronts, on_delete: :nothing)

      timestamps()
    end

    create index(:products, [:front_id])
  end
end

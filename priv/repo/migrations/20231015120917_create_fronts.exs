defmodule Shop.Repo.Migrations.CreateFronts do
  use Ecto.Migration

  def change do
    create table(:fronts) do
      add :name, :string
      add :subdomain, :string

      timestamps()
    end
  end
end

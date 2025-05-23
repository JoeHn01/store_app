defmodule Store.Repo.Migrations.CreateItemTable do
  use Ecto.Migration

  def change do
    create table(:item, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("gen_random_uuid()")
      add :name, :string
      add :description, :string
      add :price, :decimal
      add :category, :string

      timestamps()
    end
  end
end

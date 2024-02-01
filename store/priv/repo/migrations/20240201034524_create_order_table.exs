defmodule Store.Repo.Migrations.CreateOrderTable do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:order, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("gen_random_uuid()")
      add :user_id, references(:user, type: :uuid)
      add :amount, :decimal
      add :type, :string

      timestamps()
    end

    create table(:order_item, primary_key: false) do
      add :item_id, references(:item, type: :uuid, on_delete: :delete_all)
      add :order_id, references(:order, type: :uuid, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:order_item, [:item_id, :order_id])
  end
end

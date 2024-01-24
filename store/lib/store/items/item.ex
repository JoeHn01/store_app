defmodule Store.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "item" do
    field :name, :string
    field :description, :string
    field :price, :decimal
    field :category, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :description, :price, :category])
    |> validate_required([:name, :description, :price, :category])
  end
end

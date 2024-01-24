defmodule Store.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "product" do
    field :name, :string
    field :description, :string
    field :price, :decimal
    field :category, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :price, :category])
    |> validate_required([:name, :description, :price, :category])
  end
end

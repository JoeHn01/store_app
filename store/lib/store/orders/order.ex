defmodule Store.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "order" do
    belongs_to :user, Store.Accounts.User
    field :amount, :decimal
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:user_id, :amount, :type])
    |> validate_required([:amount, :type])
  end
end

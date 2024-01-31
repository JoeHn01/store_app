defmodule Store.Items do
  @moduledoc """
  The Items context contains the
  functions used for the item table.
  """

  import Ecto.Query, warn: false
  alias Store.Repo

  alias Store.Items.Item

  @doc """
  Returns the list of items.

  ## Examples

      iex> list_items()
      [%Item{}, ...]

  """
  def list_items do
    Repo.all(Item)
  end

  @doc """
  Gets a single item.

  Raises `Ecto.NoResultsError` if the Item does not exist.

  ## Examples

      iex> get_item!(123)
      %Item{}

      iex> get_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item!(id), do: Repo.get!(Item, id)

  @doc """
  Creates a item.

  ## Examples

      iex> create_item(%{field: value})
      {:ok, %Item{}}

      iex> create_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a item.

  ## Examples

      iex> update_item(item, %{field: new_value})
      {:ok, %Item{}}

      iex> update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a item.

  ## Examples

      iex> delete_item(item)
      {:ok, %Item{}}

      iex> delete_item(item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_item(%Item{} = item) do
    Repo.delete(item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item changes.

  ## Examples

      iex> change_item(item)
      %Ecto.Changeset{data: %Item{}}

  """
  def change_item(%Item{} = item, attrs \\ %{}) do
    Item.changeset(item, attrs)
  end

  @doc """
  Fetches items from the database, grouped by category.

  Returns a map where keys are category names and values are lists of items
  belonging to that category.

  ## Examples

      iex> list_items_by_category()
      %{
        "Category A" => [%Item{id: 1, category: "Category A", ...}, ...],
        "Category B" => [%Item{id: 4, category: "Category B", ...}, ...],
        # ...
      }

  """
  def list_items_by_category() do
    query =
      from(item in Item,
      group_by: [item.category, item.id],
      select: %{category: item.category, items: item}
      )
      |> Repo.all()

    Enum.group_by(query, &(&1.category), &(&1.items))
  end
 end

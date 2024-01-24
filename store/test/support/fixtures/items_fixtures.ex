defmodule Store.ItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Store.Items` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{

      })
      |> Store.Items.create_item()

    item
  end
end

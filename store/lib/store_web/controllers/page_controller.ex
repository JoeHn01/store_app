defmodule StoreWeb.PageController do
  use StoreWeb, :controller

  alias Store.Items
  alias Store.Products

  def home_admin(conn, _params) do
    render(conn, :home_admin, layout: false)
  end
  def home(conn, _params) do
    render(conn, :home, layout: false)
  end

  def menu(conn, _params) do
    items_by_category = Items.list_items_by_category()
    render(conn, :menu, layout: false, items_by_category: items_by_category)
  end

  def about(conn, _params) do
    render(conn, :about, layout: false)
  end

  def products(conn, _params) do
    products_by_category = Products.list_products_by_category()
    render(conn, :products, layout: false, products_by_category: products_by_category)
  end

  def contact(conn, _params) do
    render(conn, :contact, layout: false)
  end
end

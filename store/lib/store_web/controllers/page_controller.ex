defmodule StoreWeb.PageController do
  use StoreWeb, :controller

  def home_admin(conn, _params) do
    render(conn, :home_admin, layout: false)
  end
  def home(conn, _params) do
    render(conn, :home, layout: false)
  end

  def menu(conn, _params) do
    render(conn, :menu, layout: false)
  end

  def about(conn, _params) do
    render(conn, :about, layout: false)
  end

  def products(conn, _params) do
    render(conn, :products, layout: false)
  end

  def contact(conn, _params) do
    render(conn, :contact, layout: false)
  end
end

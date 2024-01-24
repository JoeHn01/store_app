defmodule StoreWeb.PageController do
  use StoreWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
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

  def signup(conn, _params) do
    render(conn, :signup, layout: false)
  end

  def login(conn, _params) do
    render(conn, :login, layout: false)
  end
end

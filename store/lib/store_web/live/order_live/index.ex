defmodule StoreWeb.OrderLive.Index do
  use StoreWeb, :live_view

  alias Store.Orders
  alias Store.Orders.Order

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :order_collection, Orders.list_orders())}
  end

  @impl true
  @spec handle_params(any(), any(), %{
          :assigns => atom() | %{:live_action => :edit | :index | :new, optional(any()) => any()},
          optional(any()) => any()
        }) :: {:noreply, map()}
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Order")
    |> assign(:order, Orders.get_order!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Order")
    |> assign(:order, %Order{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Orders")
    |> assign(:order, nil)
  end

  @impl true
  def handle_info({StoreWeb.OrderLive.FormComponent, {:saved, order}}, socket) do
    {:noreply, stream_insert(socket, :order_collection, order)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    order = Orders.get_order!(id)
    {:ok, _} = Orders.delete_order(order)

    {:noreply, stream_delete(socket, :order_collection, order)}
  end
end

defmodule ShopWeb.FrontLive.Index do
  use ShopWeb, :live_view

  alias Shop.Fronts
  alias Shop.Fronts.Front

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :fronts, Fronts.list_fronts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Front")
    |> assign(:front, Fronts.get_front!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Front")
    |> assign(:front, %Front{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Fronts")
    |> assign(:front, nil)
  end

  @impl true
  def handle_info({ShopWeb.FrontLive.FormComponent, {:saved, front}}, socket) do
    {:noreply, stream_insert(socket, :fronts, front)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    front = Fronts.get_front!(id)
    {:ok, _} = Fronts.delete_front(front)

    {:noreply, stream_delete(socket, :fronts, front)}
  end
end

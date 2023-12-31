defmodule ShopWeb.FrontLive.Show do
  use ShopWeb, :live_view

  alias Shop.Fronts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:front, Fronts.get_front!(id))
     |> assign(:products, Fronts.get_products_by_front_id(id))
    }
  end

  defp page_title(:show), do: "Show Front"
  defp page_title(:edit), do: "Edit Front"
end

defmodule ShopWeb.FrontLive.FormComponent do
  use ShopWeb, :live_component

  alias Shop.Fronts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage front records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="front-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Front</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{front: front} = assigns, socket) do
    changeset = Fronts.change_front(front)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"front" => front_params}, socket) do
    changeset =
      socket.assigns.front
      |> Fronts.change_front(front_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"front" => front_params}, socket) do
    save_front(socket, socket.assigns.action, front_params)
  end

  defp save_front(socket, :edit, front_params) do
    case Fronts.update_front(socket.assigns.front, front_params) do
      {:ok, front} ->
        notify_parent({:saved, front})

        {:noreply,
         socket
         |> put_flash(:info, "Front updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_front(socket, :new, front_params) do
    case Fronts.create_front(front_params) do
      {:ok, front} ->
        notify_parent({:saved, front})

        {:noreply,
         socket
         |> put_flash(:info, "Front created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

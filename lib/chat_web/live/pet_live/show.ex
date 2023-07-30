defmodule ChatWeb.PetLive.Show do
  use ChatWeb, :live_view

  alias Chat.PetLive

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:pet, PetLive.get_pet!(id))}
  end

  defp page_title(:show), do: "Show Pet"
  defp page_title(:edit), do: "Edit Pet"
end

defmodule ChatWeb.PetLive.Index do
  use ChatWeb, :live_view

  alias Chat.PetLive
  alias Chat.PetLive.Pet

  on_mount {ChatWeb.LiveAuth, :default}

  @impl true
  def mount(_params, _sessio, socket) do
     {:ok, 
    socket
    |> assign(:params, "")
    |> assign(:meta, %Flop.Meta{page_size: 10})
    |> stream(:pets, [])
  }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Pet")
    |> assign(:pet, PetLive.get_pet!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Pet")
    |> assign(:pet, %Pet{})
  end

  defp apply_action(socket, :index, params) do
    socket
    |> assign(:page_title, "Listing Pets")
    
    case PetLive.list_pets(params) do
      {:ok, {pets, meta}} ->
           socket
           |> assign(:meta, meta)
           |> assign(:params, params)
           |> stream(:pets, pets, reset: true)
    
        {:error, _meta} -> {:noreply, push_navigate(socket, to: ~p"/pets")}
      
    end
  end

  @impl true
  def handle_info({ChatWeb.PetLive.FormComponent, {:saved, pet}}, socket) do
    {:noreply, stream_insert(socket, :pets, pet)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    pet = PetLive.get_pet!(id)
    {:ok, _} = PetLive.delete_pet(pet)

    {:noreply, stream_delete(socket, :pets, pet)}
  end

  @impl true
def handle_event("update-filter", params, socket) do
  {:noreply, push_patch(socket, to: ~p"/pets?#{params}")}
end

@impl true
def handle_event("reset-filter", _, %{assigns: assigns} = socket) do
  flop = assigns.meta.flop |> Flop.set_page(1) |> Flop.reset_filters()
  path = Flop.Phoenix.build_path(~p"/pets", flop, backend: assigns.meta.backend)
  {:noreply, push_patch(socket, to: path)}
end
end

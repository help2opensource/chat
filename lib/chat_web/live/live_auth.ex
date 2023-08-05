defmodule ChatWeb.LiveAuth do
    import Phoenix.LiveView
    import Phoenix.Component
    alias Chat.Users
    alias Chat.Users.User
   
    def on_mount(:default, _, session, socket) do
      socket = assign_current_user(socket, session)
      case socket.assigns.current_user do
        nil ->
          {:halt,
            socket
            |> put_flash(:error, "You have to Sign in to continue")
            |> redirect(to: "/users/log_in")}
  
        %User{} ->
          {:cont, socket}
  
      end
    end

    def on_mount(:admin, _, session, socket) do
      socket = assign_current_user(socket, session)
      case socket.assigns.current_user.email do
        "admin@gmail.com" ->
          {:cont, socket}
          
        _ ->
          {:halt,
            socket
            |> put_flash(:error, "You have to Sign in to as Administrator to continue")
            |> redirect(to: "/users/log_in")}
      end
    end
  
    defp assign_current_user(socket, session) do
      case session do
        %{"user_token" => user_token} ->
          assign_new(socket, :current_user, fn ->
            Users.get_user_by_session_token(user_token)
          end)
  
        %{} ->
          assign_new(socket, :current_user, fn -> nil end)
          
      end
    end
  end
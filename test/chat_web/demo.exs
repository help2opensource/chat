defmodule ChatWeb.UserListTest do
    use ExUnit.Case, async: true
    use Wallaby.Feature
    import Wallaby.Query, only: [css: 2, text_field: 1, button: 1]
  
    @tag timeout: :infinity
    feature "users can sent message", %{session: session} do
      for item <- 2000..5000 do
        IO.puts item
      session
      |> visit("/?name=#{item}")
      |> fill_in(text_field("chat-input"), with: "This is the message sent by user #{item}")
      |> click(button("sendButton"))
    end 
    end

    
  end
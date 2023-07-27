defmodule ChatWeb.UserListTest do
    use ExUnit.Case, async: true
    use Wallaby.Feature

    import Wallaby.Query, only: [css: 2, text_field: 1, button: 1]
  
    @tag timeout: :infinity
    feature "users have names", %{session: session} do
    
    for item <- 1..10000 do
      session
      |> visit("/")
      |> find(Query.css(".user", count: 3))
      |> List.first()
      |> assert_has(Query.css(".user-name", text: "Chris"))

      IO.puts item
        
    end
    end

    feature "users can sent message", %{session: session} do
      session
      |> visit("/")
      |> fill_in(text_field("chat-input"), with: "Write my first Wallaby test")
     
    end

  end
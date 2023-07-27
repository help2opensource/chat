defmodule ChatWeb.UserListTest do
    use ExUnit.Case, async: true
    use Wallaby.Feature
  
    @tag timeout: :infinity
    feature "users have names", %{session: session} do
    
    for item <- 1..10 do
      session
      |> visit("/")
      |> find(Query.css(".user", count: 3))
      |> List.first()
      |> assert_has(Query.css(".user-name", text: "Chris"))

      IO.puts item
        
    end
    end
  end
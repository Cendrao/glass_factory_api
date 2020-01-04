defmodule GlassFactoryApi.Members.MemberTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.Members.Avatar
  alias GlassFactoryApi.Members.Member

  describe "to_struct/1" do
    test "parses a map to a Member struct" do
      data_map = %{
        "name" => "John Doe",
        "id" => 10,
        "email" => "john.doe@example.org",
        "avatar" => %{"url" => "/default_user/avatar/2632.svg"}
      }

      assert %Member{
               name: "John Doe",
               id: 10,
               email: "john.doe@example.org",
               avatar: %Avatar{
                 url: "/default_user/avatar/2632.svg"
               }
             } = Member.to_struct(data_map)
    end
  end
end

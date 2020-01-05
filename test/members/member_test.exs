defmodule GlassFactoryApi.Members.MemberTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.Members.Avatar
  alias GlassFactoryApi.Members.Member

  describe "to_struct/1" do
    test "parses a map to a Member struct" do
      config = %{
        api_url: "http://example.org/",
        subdomain: "example",
        user_token: "test_user_token",
        user_email: "foo@example.org"
      }

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
                 url: "http://example.org/default_user/avatar/2632.svg"
               }
             } = Member.to_struct(data_map, config)
    end
  end
end

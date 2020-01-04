defmodule GlassFactoryApi.Members.AvatarTest do
  use ExUnit.Case, async: false

  alias GlassFactoryApi.Members.Avatar

  describe "to_struct/1" do
    test "returns an avatar struct" do
      data_map = %{
        "url" => "http://example.org/user/1/avatar.jpeg",
        "medium" => %{"url" => "http://example.org/user/1/avatar_medium.jpeg"},
        "small" => %{"url" => "http://example.org/user/1/avatar_small.jpeg"},
        "thumb" => %{"url" => "http://example.org/user/1/avatar_thumb.jpeg"}
      }

      assert %Avatar{
               url: "http://example.org/user/1/avatar.jpeg",
               medium: %{url: "http://example.org/user/1/avatar_medium.jpeg"},
               small: %{url: "http://example.org/user/1/avatar_small.jpeg"},
               thumb: %{url: "http://example.org/user/1/avatar_thumb.jpeg"}
             } = Avatar.to_struct(data_map)
    end
  end
end

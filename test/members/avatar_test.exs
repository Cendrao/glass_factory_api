defmodule GlassFactoryApi.Members.AvatarTest do
  use ExUnit.Case, async: false

  alias GlassFactoryApi.Members.Avatar

  describe "to_struct/1" do
    test "returns an avatar struct" do
      config = %{api_url: "http://example.org/"}

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
             } = Avatar.to_struct(data_map, config)
    end

    test "when the api does not send a full URL it normalizes it" do
      config = %{api_url: "http://example.org/"}

      data_map = %{
        "url" => "/user/1/avatar.jpeg",
        "medium" => %{"url" => "/user/1/avatar_medium.jpeg"},
        "small" => %{"url" => "/user/1/avatar_small.jpeg"},
        "thumb" => %{"url" => "/user/1/avatar_thumb.jpeg"}
      }

      assert %Avatar{
               url: "http://example.org/user/1/avatar.jpeg",
               medium: %{url: "http://example.org/user/1/avatar_medium.jpeg"},
               small: %{url: "http://example.org/user/1/avatar_small.jpeg"},
               thumb: %{url: "http://example.org/user/1/avatar_thumb.jpeg"}
             } = Avatar.to_struct(data_map, config)
    end
  end
end

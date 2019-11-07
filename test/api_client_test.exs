defmodule GlassFactoryApi.ApiClientTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.{ApiClient, HTTPMockAdapter, Configuration}

  describe "get/2" do
    test "returns a map with the requested information" do
      config = %Configuration{
        adapter: HTTPMockAdapter
      }

      assert {:ok, response} = ApiClient.get("users", config)

      assert %{status_code: 200, body: body, headers: headers} = response
      assert body == "{ \"description\": \"some foo json\" }"
      assert headers == []
    end
  end
end

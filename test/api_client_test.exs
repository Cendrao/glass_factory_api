defmodule GlassFactoryApi.ApiClientTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.HTTPMockAdapter

  describe "get/2" do
    test "returns a map with the requested information" do
      assert {:ok, response} = ApiClient.get("users", HTTPMockAdapter)

      assert %{status_code: 200, body: body, headers: headers} = response
      assert body == "{ \"description\": \"some foo json\" }"
      assert headers == []
    end
  end
end

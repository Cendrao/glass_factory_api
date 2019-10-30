defmodule GlassFactoryApi.ApiClientTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.HttpmockAdapter

  describe "get/2" do
    test "returns a map with the requested information" do
      request_header = [
        "X-Account-Subdomain": "foobar",
        "X-User-Token": "super-secret-token",
        "X-User-Email": "not-so-secret@email.com",
        Accept: "application/json"
      ]

      assert {:ok, response} = ApiClient.get("users", HttpmockAdapter)

      assert %{status_code: 200, body: body, headers: headers} = response
      assert body == "{ \"description\": \"some foo json\" }"
      assert headers == []
    end
  end
end

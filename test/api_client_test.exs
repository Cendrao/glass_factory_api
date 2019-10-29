defmodule GlassFactoryApi.ApiClientTest do
  use ExUnit.Case, async: true
  import Mock

  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.HttpoisonAdapter

  describe "get/2" do
    test "returns a map with the requested information" do
      request_header = [
        "X-Account-Subdomain": "foobar",
        "X-User-Token": "super-secret-token",
        "X-User-Email": "not-so-secret@email.com",
        Accept: "application/json"
      ]

      response = %{
        status_code: 200,
        body: "{ \"description\": \"some foo json\" }",
        headers: []
      }

      with_mock HttpoisonAdapter,
        get: fn "https://foobar.glassfactory.io/api/public/v1/users", request_header ->
          {:ok, response}
        end do
        assert {:ok, response} = ApiClient.get("users")

        assert %{status_code: 200, body: body, headers: headers} = response
        assert body == "{ \"description\": \"some foo json\" }"
        assert headers == []
      end
    end
  end
end

defmodule GlassFactoryApi.ApiClientTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.ApiClient

  setup do
    bypass = Bypass.open()

    config = %{
      subdomain: "foobar",
      user_token: "super-secret-token",
      user_email: "not-so-secret@example.org",
      api_url: "http://localhost:#{bypass.port}"
    }

    {:ok, bypass: bypass, config: config}
  end

  describe "get/3" do
    test "returns a map with the requested information", %{bypass: bypass, config: config} do
      request_response = ~s<{ "description": "some foo json" }>

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      assert {:ok, response} = ApiClient.get("users", [], config)

      assert %{status: 200, body: body, headers: headers} = response
      assert body == %{"description" => "some foo json"}
    end

    test "returns the error when connection fail", %{bypass: bypass, config: config} do
      Bypass.down(bypass)

      assert {:error, "econnrefused"} = ApiClient.get("users", [], config)
    end
  end
end

defmodule GlassFactoryApi.HttpoisonAdapterTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.HttpoisonAdapter

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "get/2" do
    test "returns a map with the response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 200, ~s<{{ "description": "some foo json" }}>)
      end)

      assert {:ok, %{status_code: 200, body: body}} =
               HttpoisonAdapter.get(endpoint_url(bypass.port), [])

      assert body = "{ \"description\": \"some foo json\" }"
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}/"
end

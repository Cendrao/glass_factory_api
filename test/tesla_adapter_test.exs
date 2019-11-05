defmodule GlassFactoryApi.TeslaAdapterTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.TeslaAdapter

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
               TeslaAdapter.get(endpoint_url(bypass.port), [])

      assert body = "{ \"description\": \"some foo json\" }"
    end

    test "returns an error when the response is 500", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 500, ~s<{{ "internal server error" }}>)
      end)

      assert {:error, %{status_code: 500, body: body}} =
               TeslaAdapter.get(endpoint_url(bypass.port), [])

      assert body = "internal server error"
    end

    test "returns an error when the request fails" do
      assert {:error, :econnrefused} = TeslaAdapter.get("www.nonexist.org", [])
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}/"
end

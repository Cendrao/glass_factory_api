defmodule GlassFactoryApi.HttpoisonAdapterTest do
  use ExUnit.Case, async: true
  import Mox

  alias GlassFactoryApi.HttpoisonAdapter

  describe "get/2" do
    test "returns a map with the response" do
      request_response = %HTTPoison.Response{
        status_code: 200,
        body: "{ \"description\": \"some foo json\" }"
      }

      stub(HTTPoison, :get, {:ok, request_response})

      assert {:ok, %{status_code: 200, body: body}} =
               GlassFactoryApi.HttpoisonAdapter.get("http://www.foo.bar", [])

      assert body = "{ \"description\": \"some foo json\" }"
    end

    test "returns an error map when request not successed" do
      error_response = %HTTPoison.Error{id: nil, reason: :nxdomain}

      stub(HTTPoison, :get, {:error, error_response})

      assert {:error, message} = GlassFactoryApi.HttpoisonAdapter.get("http://www.foo.bar", [])
      assert message = "nxdomain"
    end
  end
end

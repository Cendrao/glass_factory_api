defmodule GlassFactoryApi.ClientsTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.Clients
  alias GlassFactoryApi.Clients.Client

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

  describe "get_client/2" do
    test "returns the client of the given id", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.Clients.get()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      assert {
               :ok,
               %Client{
                 id: 1234,
                 name: "Google",
                 archived_at: nil,
                 owner_id: 567,
                 office_id: 789
               }
             } = Clients.get_client(1234, config)
    end

    test "returns nil when the id does not exist", %{bypass: bypass, config: config} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "")
      end)

      client = Clients.get_client(1, config)

      assert client == {:error, "Can't find a client with id 1"}
    end
  end

  describe "get_client!/2" do
    test "returns the client of the given id", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.Clients.get()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      assert %Client{
               id: 1234,
               name: "Google",
               archived_at: nil,
               owner_id: 567,
               office_id: 789
             } = Clients.get_client!(1234, config)
    end

    test "raises an exception when the id does not exist", %{bypass: bypass, config: config} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "")
      end)

      assert_raise RuntimeError, ~r/^Can't find a client with id 1/, fn ->
        Clients.get_client!(1, config)
      end
    end
  end

  describe "list_clients/1" do
    test "returns all clients", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.Clients.list()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      clients = [
        %Client{
          id: 1234,
          name: "Google",
          archived_at: nil,
          owner_id: 567,
          office_id: 789
        },
        %Client{
          id: 1235,
          name: "Facebook",
          archived_at: nil,
          owner_id: 567,
          office_id: 789
        }
      ]

      assert {:ok, clients} == Clients.list_clients(config)
    end

    test "returns error when something went wrong", %{bypass: bypass, config: config} do
      Bypass.down(bypass)

      assert {:error, "econnrefused"} == Clients.list_clients(config)
    end
  end
end

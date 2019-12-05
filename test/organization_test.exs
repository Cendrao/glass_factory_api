defmodule GlassFactoryApi.OrganizationTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.Organization
  alias GlassFactoryApi.Organization.Role

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

  describe "list_roles/1" do
    test "returns a list of organization roles", %{bypass: bypass, config: config} do
      response = GlassFactoryApi.Fixtures.Roles.list()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, response)
      end)

      assert {:ok, roles} = Organization.list_roles(config)

      assert roles == [
               %Role{
                 id: 3110,
                 name: "partner",
                 description: "Partner",
                 department_id: 10,
                 is_used: true,
                 rate: nil,
                 cost: nil,
                 currency: nil,
                 archived: false
               },
               %Role{
                 id: 3105,
                 name: "assoc",
                 description: "Associate",
                 department_id: 10,
                 is_used: true,
                 rate: nil,
                 cost: nil,
                 currency: nil,
                 archived: false
               }
             ]
    end

    test "returns a tuple with error and a message when something went wrong", %{
      bypass: bypass,
      config: config
    } do
      Bypass.down(bypass)

      assert {:error, "econnrefused"} = Organization.list_roles(config)
    end
  end

  describe "list_roles!/1" do
    test "returns a list of organization roles", %{bypass: bypass, config: config} do
      response = GlassFactoryApi.Fixtures.Roles.list()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, response)
      end)

      assert [
               %Role{
                 id: 3110,
                 name: "partner",
                 description: "Partner",
                 department_id: 10,
                 is_used: true,
                 rate: nil,
                 cost: nil,
                 currency: nil,
                 archived: false
               },
               %Role{
                 id: 3105,
                 name: "assoc",
                 description: "Associate",
                 department_id: 10,
                 is_used: true,
                 rate: nil,
                 cost: nil,
                 currency: nil,
                 archived: false
               }
             ] == Organization.list_roles!(config)
    end

    test "raises an error when something went wrong", %{bypass: bypass, config: config} do
      Bypass.down(bypass)

      assert_raise RuntimeError, "econnrefused", fn ->
        Organization.list_roles!(config)
      end
    end
  end
end

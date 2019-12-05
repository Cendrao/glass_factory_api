defmodule GlassFactoryApi.Projects.ActivitiesTest do
  use ExUnit.Case
  alias GlassFactoryApi.Projects.Activities
  alias GlassFactoryApi.Activities.Activity

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

  describe "list_activities/2" do
    test "returns a list of activities", %{bypass: bypass, config: config} do
      expected_response = GlassFactoryApi.Fixtures.Projects.Activities.list()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, expected_response)
      end)

      assert {:ok,
              [
                %Activity{
                  id: 1122,
                  name: "General Time"
                },
                %Activity{
                  id: 1123,
                  name: "Mobile App"
                },
                %Activity{
                  id: 1124,
                  name: "Integrations"
                }
              ]} == Activities.list_activities(1234, config)
    end

    test "returns error when something went wrong", %{bypass: bypass, config: config} do
      Bypass.down(bypass)

      assert {:error, "econnrefused"} == Activities.list_activities(1234, config)
    end
  end

  describe "list_activities!/2" do
    test "returns a list of activities", %{bypass: bypass, config: config} do
      expected_response = GlassFactoryApi.Fixtures.Projects.Activities.list()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, expected_response)
      end)

      assert [
               %Activity{
                 id: 1122,
                 name: "General Time"
               },
               %Activity{
                 id: 1123,
                 name: "Mobile App"
               },
               %Activity{
                 id: 1124,
                 name: "Integrations"
               }
             ] == Activities.list_activities!(1234, config)
    end

    test "raises if something went wrong", %{bypass: bypass, config: config} do
      Bypass.down(bypass)

      assert_raise RuntimeError, "econnrefused", fn ->
        Activities.list_activities!(1234, config)
      end
    end
  end
end

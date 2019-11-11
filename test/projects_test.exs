defmodule GlassFactoryApi.ProjectsTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.Projects
  alias GlassFactoryApi.Projects.Project

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

  describe "list_projects/1" do
    test "returns a list of projects", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.Projects.list()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      assert {:ok,
              [
                %Project{
                  id: 99999,
                  name: "Big project",
                  archived: false,
                  manager_id: 111_222
                }
              ]} = Projects.list_projects(config)
    end

    test "returns error when something went wrong", %{bypass: bypass, config: config} do
      Bypass.down(bypass)

      assert {:error, "econnrefused"} == Projects.list_projects(config)
    end
  end

  describe "list_projects!/1" do
    test "returns a list of projects", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.Projects.list()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      assert [
               %Project{
                 id: 99999,
                 name: "Big project",
                 archived: false,
                 manager_id: 111_222
               }
             ] = Projects.list_projects!(config)
    end

    test "raises if something went wrong", %{bypass: bypass, config: config} do
      Bypass.down(bypass)

      assert_raise RuntimeError, "econnrefused", fn ->
        Projects.list_projects!(config)
      end
    end
  end

  describe "get_project/2" do
    test "returns a project given the id", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.Projects.get()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      assert {:ok,
              %Project{
                id: 99999,
                name: "Big project",
                archived: false,
                manager_id: 111_222
              }} = Projects.get_project("99999", config)
    end

    test "returns nil when a project doesn't exist", %{bypass: bypass, config: config} do
      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("text/plain")
        |> Plug.Conn.resp(404, "")
      end)

      assert {:error, message} = Projects.get_project("99999", config)
      assert message == "Can't find a project with ID 99999"
    end
  end

  describe "get_project!/2" do
    test "returns a project given the id", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.Projects.get()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      assert %Project{
               id: 99999,
               name: "Big project",
               archived: false,
               manager_id: 111_222
             } = Projects.get_project!("99999", config)
    end

    test "returns nil when a project doesn't exist", %{bypass: bypass, config: config} do
      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("text/plain")
        |> Plug.Conn.resp(404, "")
      end)

      assert_raise RuntimeError, "Can't find a project with ID 99999", fn ->
        Projects.get_project!("99999", config)
      end
    end
  end
end

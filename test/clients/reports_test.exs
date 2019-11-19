defmodule GlassFactoryApi.Clients.ReportsTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.Clients.Reports
  alias GlassFactoryApi.Clients.Reports.TimeReport

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

  describe "list_time_reports/2" do
    test "returns time reports of the given client id", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.Clients.Reports.list_time_reports()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      assert {
               :ok,
               [
                 %TimeReport{
                   client_id: 2079,
                   project_id: 14330,
                   job_id: nil,
                   activity_id: nil,
                   user_id: 3,
                   role_id: 1480,
                   date: "2018-07-10",
                   planned: 8,
                   time: 0
                 }
               ]
             } = Reports.list_time_reports(2079, config)
    end

    test "returns empty array when not time reports are found", %{bypass: bypass, config: config} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "")
      end)

      time_reports = Reports.list_time_reports(1, config)

      assert time_reports == {:error, "Can't find time reports for client id 1"}
    end
  end

  describe "list_time_reports!/2" do
    test "returns time reports of the given client id", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.Clients.Reports.list_time_reports()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      assert [
               %TimeReport{
                 client_id: 2079,
                 project_id: 14330,
                 job_id: nil,
                 activity_id: nil,
                 user_id: 3,
                 role_id: 1480,
                 date: "2018-07-10",
                 planned: 8,
                 time: 0
               }
             ] = Reports.list_time_reports!(2079, config)
    end

    test "raises an exception when not found", %{bypass: bypass, config: config} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "")
      end)

      assert_raise RuntimeError, ~r/^Can't find time reports for client id 1/, fn ->
        Reports.list_time_reports!(1, config)
      end
    end
  end
end

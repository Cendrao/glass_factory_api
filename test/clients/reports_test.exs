defmodule GlassFactoryApi.Clients.ReportsTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.Clients.Reports
  alias GlassFactoryApi.Clients.Reports.{TimeReport, RatesAndCostsReport}

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
             } = Reports.list_time_reports(2079, [date: ~D[2019-01-01]], config)
    end

    test "returns empty array when not time reports are found", %{bypass: bypass, config: config} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "")
      end)

      time_reports = Reports.list_time_reports(1, [date: ~D[2019-01-01]], config)

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
             ] = Reports.list_time_reports!(2079, [date: ~D[2019-01-01]], config)
    end

    test "raises an exception when not found", %{bypass: bypass, config: config} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "")
      end)

      assert_raise RuntimeError, ~r/^Can't find time reports for client id 1/, fn ->
        Reports.list_time_reports!(1, [user_id: 123], config)
      end
    end
  end

  describe "list_rates_and_costs_reports/3" do
    test "returns reports of the given client id", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.Clients.Reports.list_rates_and_costs_reports()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      expected = %RatesAndCostsReport{
        client_id: 1234,
        project_id: 12345,
        job_id: nil,
        activity_id: 123_456,
        user_id: 222,
        role_id: 1234,
        date: "2018-06-19",
        time: 8,
        rate: 35,
        cost: 35
      }

      assert {:ok, [report]} = Reports.list_rates_and_costs_reports(2079, [], config)

      assert expected == report
    end

    test "returns empty array when no rates and costs reports are found", %{
      bypass: bypass,
      config: config
    } do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "")
      end)

      time_reports = Reports.list_rates_and_costs_reports(1, [], config)

      assert time_reports == {:error, "Can't find rates and costs reports for client id 1"}
    end
  end

  describe "list_rates_and_costs_reports!/3" do
    test "returns rates and costs reports of the given client id", %{
      bypass: bypass,
      config: config
    } do
      expected_response = GlassFactoryApi.Fixtures.Clients.Reports.list_rates_and_costs_reports()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, expected_response)
      end)

      assert [
               %RatesAndCostsReport{
                 client_id: 1234,
                 project_id: 12345,
                 job_id: nil,
                 activity_id: 123_456,
                 user_id: 222,
                 role_id: 1234,
                 date: "2018-06-19",
                 time: 8,
                 rate: 35,
                 cost: 35
               }
             ] = Reports.list_rates_and_costs_reports!(1234, [], config)
    end

    test "raises an exception when not found", %{bypass: bypass, config: config} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "")
      end)

      assert_raise RuntimeError, ~r/^Can't find rates and costs reports for client id 1/, fn ->
        Reports.list_rates_and_costs_reports!(1, [], config)
      end
    end
  end
end

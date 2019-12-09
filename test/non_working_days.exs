defmodule GlassFactoryApi.NonWorkingDaysTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.NonWorkingDays
  alias GlassFactoryApi.NonWorkingDays.NonWorkingDay

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

  describe "get_non_working_days/2" do
    test "returns a list of non working days for all offices", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.NonWorkingDays.get_all_non_working_days()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      non_working_days = [
        %NonWorkingDay{
          id: 102,
          start_date: "2017-07-04",
          end_date: "2017-07-04",
          name: "Independence Day",
          office_id: 101
        },
        %NonWorkingDay{
          id: 103,
          start_date: "2017-12-25",
          end_date: "2017-12-25",
          name: "Christmas Day",
          office_id: 101
        }
      ]

      assert {:ok, non_working_days} == NonWorkingDays.get_non_working_days([], config)
    end

    test "with filters, returns a filtered list of non working days", %{
      bypass: bypass,
      config: config
    } do
      request_response = GlassFactoryApi.Fixtures.NonWorkingDays.get_filtered_non_working_days()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      filtered_non_working_days = [
        %NonWorkingDay{
          id: 103,
          start_date: "2017-12-25",
          end_date: "2017-12-25",
          name: "Christmas Day",
          office_id: 101
        }
      ]

      assert {:ok, filtered_non_working_days} ==
               NonWorkingDays.get_non_working_days(
                 [start: '2019-12-01', end: '2019-12-31'],
                 config
               )
    end

    test "returns error when something goes wrong", %{bypass: bypass, config: config} do
      Bypass.down(bypass)

      assert {:error, "econnrefused"} == NonWorkingDays.get_non_working_days([], config)
    end
  end

  describe "get_non_working_days!/2" do
    test "returns a list of non working days for all offices", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.NonWorkingDays.get_all_non_working_days()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      non_working_days = [
        %NonWorkingDay{
          id: 102,
          start_date: "2017-07-04",
          end_date: "2017-07-04",
          name: "Independence Day",
          office_id: 101
        },
        %NonWorkingDay{
          id: 103,
          start_date: "2017-12-25",
          end_date: "2017-12-25",
          name: "Christmas Day",
          office_id: 101
        }
      ]

      assert non_working_days == NonWorkingDays.get_non_working_days!([], config)
    end

    test "raises an exception when something goes wrong", %{bypass: bypass, config: config} do
      Bypass.down(bypass)

      assert_raise RuntimeError, "econnrefused", fn ->
        NonWorkingDays.get_non_working_days!([], config)
      end
    end
  end
end

defmodule GlassFactoryApi.VacationsTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.Vacations
  alias GlassFactoryApi.Vacations.Vacation

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

  describe "get_vacations/2" do
    test "returns a list of vacations for all users", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.Vacations.get_all_users()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      vacations = [
        %Vacation{
          id: 119,
          upcoming: false,
          daily_hours: 8,
          start_date: "2017-07-24",
          end_date: "2017-07-30",
          days: 7,
          vacation_type: "paid",
          creator_id: 722,
          user_id: 722
        },
        %Vacation{
          id: 132,
          upcoming: false,
          daily_hours: 8,
          start_date: "2019-07-20",
          end_date: "2019-07-30",
          days: 10,
          vacation_type: "paid",
          creator_id: 734,
          user_id: 734
        }
      ]

      assert {:ok, vacations} == Vacations.get_vacations([], config)
    end

    test "with a user_id pass by filter, returns a list of vacations for that user", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.Vacations.get_one_user()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      user_vacations = [
       %Vacation{
          id: 132,
          upcoming: false,
          daily_hours: 8,
          start_date: "2019-07-20",
          end_date: "2019-07-30",
          days: 10,
          vacation_type: "paid",
          creator_id: 734,
          user_id: 734
        }
      ]

      assert {:ok, user_vacations} == Vacations.get_vacations([user_id: 734], config)
    end

    test "with a invalid user_id, returns an error", %{bypass: bypass, config: config} do
      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.resp(404, "")
      end)

      user_vacations = Vacations.get_vacations([user_id: 1], config)

      assert user_vacations == {:error, "Vacations not found"}
    end
  end

  describe "get_vacations!/2" do
    test "returs a list of vacations for all users", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.Vacations.get_all_users()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      vacations = [
        %Vacation{
          id: 119,
          upcoming: false,
          daily_hours: 8,
          start_date: "2017-07-24",
          end_date: "2017-07-30",
          days: 7,
          vacation_type: "paid",
          creator_id: 722,
          user_id: 722
        },
        %Vacation{
          id: 132,
          upcoming: false,
          daily_hours: 8,
          start_date: "2019-07-20",
          end_date: "2019-07-30",
          days: 10,
          vacation_type: "paid",
          creator_id: 734,
          user_id: 734
        }
      ]

      assert vacations == Vacations.get_vacations!([], config)
    end

    test "raises an exception when something went wrong", %{bypass: bypass, config: config} do
      Bypass.down(bypass)

      assert_raise RuntimeError, "econnrefused", fn ->
        Vacations.get_vacations!([], config)
      end
    end
  end
end

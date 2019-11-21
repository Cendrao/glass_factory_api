defmodule GlassFactoryApi.Vacations.VacationTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.Vacations.Vacation

  describe "to_struct/1" do
    test "parses a map to a Vacation struct" do
      data_map = %{
        "id" => "119",
        "upcoming" => false,
        "daily_hours" => "8",
        "start_date" => "2017-07-24",
        "end_date" => "2017-07-30",
        "days" => "7",
        "vacation_type" => "paid",
        "creator_id" => "722",
        "user_id" => "722"
      }

      assert %Vacation{
               id: "119",
               upcoming: false,
               daily_hours: "8",
               start_date: "2017-07-24",
               end_date: "2017-07-30",
               days: "7",
               vacation_type: "paid",
               creator_id: "722",
               user_id: "722"
             } = Vacation.to_struct(data_map)
    end
  end
end

defmodule GlassFactoryApi.NonWorkingDays.NoWorkingDayTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.NonWorkingDays.NonWorkingDay

  describe "to_struct/1" do
    test "parses a map to a NonWorkingDay struct" do
      data_map = %{
        "id" => "102",
        "start_date" => "2017-07-04",
        "end_date" => "2017-07-04",
        "name" => "Independence Day",
        "office_id" => "101"
      }

      assert %NonWorkingDay{
               id: "102",
               start_date: "2017-07-04",
               end_date: "2017-07-04",
               name: "Independence Day",
               office_id: "101"
             } = NonWorkingDay.to_struct(data_map)
    end
  end
end

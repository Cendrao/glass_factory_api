defmodule GlassFactoryApi.Clients.Reports.TimeReportTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.Clients.Reports.TimeReport

  describe "to_struct/1" do
    test "parses a map to a Time struct" do
      data_map = %{
        "client_id" => 2079,
        "project_id" => 14330,
        "job_id" => nil,
        "activity_id" => nil,
        "user_id" => 3,
        "role_id" => 1480,
        "date" => "2018-07-10",
        "planned" => 8,
        "time" => 0
      }

      assert %TimeReport{
               client_id: 2079,
               project_id: 14330,
               job_id: nil,
               activity_id: nil,
               user_id: 3,
               role_id: 1480,
               date: "2018-07-10",
               planned: 8,
               time: 0
             } = TimeReport.to_struct(data_map)
    end
  end
end

defmodule GlassFactoryApi.Clients.Reports.RatesAndCostsTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.Clients.Reports.RatesAndCostsReport

  describe "to_struct/1" do
    test "parses a map to a Rates and Costs struct" do
      data_map = %{
        "client_id" => 1234,
        "project_id" => 12345,
        "job_id" => nil,
        "activity_id" => 123_456,
        "user_id" => 222,
        "role_id" => 1234,
        "date" => "2018-06-19",
        "time" => 8,
        "rate" => 35,
        "cost" => 35
      }

      assert %RatesAndCostsReport{
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
             } = RatesAndCostsReport.to_struct(data_map)
    end
  end
end

defmodule GlassFactoryApi.Activities.ActivityTest do
  use ExUnit.Case
  alias GlassFactoryApi.Activities.Activity

  describe "to_struct/1" do
    test "parses a map to a Activity struct" do
      data_map = %{
        "id" => 1122,
        "name" => "General Time"
      }

      assert %Activity{
               id: 1122,
               name: "General Time"
             } == Activity.to_struct(data_map)
    end
  end
end

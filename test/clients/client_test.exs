defmodule GlassFactoryApi.Clients.ClientTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.Clients.Client

  describe "to_struct/1" do
    test "parses a map to a Client struct" do
      data_map = %{
        "id" => 1234,
        "name" => "Google",
        "archived_at" => nil,
        "owner_id" => 567,
        "office_id" => 789
      }

      assert %Client{
               id: 1234,
               name: "Google",
               archived_at: nil,
               owner_id: 567,
               office_id: 789
             } = Client.to_struct(data_map)
    end
  end
end

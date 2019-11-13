defmodule GlassFactoryApi.Projects.ProjectTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.Projects.Project

  describe "to_struct/1" do
    test "parses a map to a Project struct" do
      data_map = %{
        "name" => "Big project",
        "id" => "99999",
        "archived" => false,
        "manager_id" => "999100"
      }

      assert %Project{
               name: "Big project",
               id: "99999",
               archived: false,
               manager_id: "999100"
             } = Project.to_struct(data_map)
    end
  end
end

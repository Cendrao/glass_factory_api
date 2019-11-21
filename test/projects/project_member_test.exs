defmodule GlassFactoryApi.Projects.ProjectMemberTest do
  use ExUnit.Case, async: false

  alias GlassFactoryApi.Projects.ProjectMember

  describe "to_struct/1" do
    test "parses a map to a ProjectMember" do
      attrs = %{"id" => "1", "user_id" => "123", "project_id" => "456"}

      assert %ProjectMember{
               id: "1",
               user_id: "123",
               project_id: "456"
             } == ProjectMember.to_struct(attrs)
    end
  end
end

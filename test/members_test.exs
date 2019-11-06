defmodule GlassFactoryApi.MembersTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.Members
  alias GlassFactoryApi.Members.Member

  setup do
    bypass = Bypass.open()

    Application.put_env(
      :glass_factory_api,
      GlassFactoryApi.ApiClient,
      api_url: "http://localhost:#{bypass.port}"
    )

    {:ok, bypass: bypass}
  end

  describe "list_members/0" do
    test "returns a list of members", %{bypass: bypass} do
      request_response = GlassFactoryApi.Fixtures.Members.list()

      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 200, request_response)
      end)

      assert [
               %Member{
                 id: 2666,
                 name: "John Doe",
                 archived: false,
                 capacity: 8.0,
                 email: "john.doe@example.org",
                 freelancer: false,
                 joined_at: "2019-01-01"
               }
             ] == Members.list_members()
    end
  end

  describe "get_member/1" do
    test "returns the member of the given id", %{bypass: bypass} do
      request_response = GlassFactoryApi.Fixtures.Members.get()

      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 200, request_response)
      end)

      assert %Member{
               id: 2666,
               name: "John Doe",
               archived: false,
               capacity: 8.0,
               email: "john.doe@example.org",
               freelancer: false,
               joined_at: "2019-01-01"
             } = Members.get_member(2666)
    end

    test "returns nil when the id does not exist", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "")
      end)

      assert nil == Members.get_member(1)
    end
  end
end

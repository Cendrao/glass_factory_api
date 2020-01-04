defmodule GlassFactoryApi.MembersTest do
  use ExUnit.Case, async: true

  alias GlassFactoryApi.Members
  alias GlassFactoryApi.Members.Avatar
  alias GlassFactoryApi.Members.Member

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

  describe "list_members/1" do
    test "returns a list of members", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.Members.list()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      assert {:ok,
              [
                %Member{
                  id: 2666,
                  name: "John Doe",
                  archived: false,
                  capacity: 8.0,
                  email: "john.doe@example.org",
                  freelancer: false,
                  joined_at: "2019-01-01",
                  avatar: %Avatar{
                    url: "/default_avatar/user/2666.svg",
                    medium: %{url: "/default_avatar/user/2666.svg"},
                    small: %{url: "/default_avatar/user/2666.svg"},
                    thumb: %{url: "/default_avatar/user/2666.svg"}
                  }
                }
              ]} == Members.list_members(config)
    end
  end

  describe "list_members!/1" do
    test "returns a list of members", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.Members.list()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      assert [
               %Member{
                 id: 2666,
                 name: "John Doe",
                 archived: false,
                 capacity: 8.0,
                 email: "john.doe@example.org",
                 freelancer: false,
                 joined_at: "2019-01-01",
                 avatar: %Avatar{
                   url: "/default_avatar/user/2666.svg",
                   medium: %{url: "/default_avatar/user/2666.svg"},
                   small: %{url: "/default_avatar/user/2666.svg"},
                   thumb: %{url: "/default_avatar/user/2666.svg"}
                 }
               }
             ] == Members.list_members!(config)
    end
  end

  describe "get_member/2" do
    test "returns the member of the given id", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.Members.get()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      assert {:ok,
              %Member{
                id: 2666,
                name: "John Doe",
                archived: false,
                capacity: 8.0,
                email: "john.doe@example.org",
                freelancer: false,
                joined_at: "2019-01-01",
                avatar: %Avatar{
                  url: "/default_avatar/user/2666.svg",
                  medium: %{url: "/default_avatar/user/2666.svg"},
                  small: %{url: "/default_avatar/user/2666.svg"},
                  thumb: %{url: "/default_avatar/user/2666.svg"}
                }
              }} = Members.get_member(2666, config)
    end

    test "returns nil when the id does not exist", %{bypass: bypass, config: config} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "")
      end)

      assert {:error, "Can't find a member with ID 1"} == Members.get_member(1, config)
    end
  end

  describe "get_member!/2" do
    test "returns the member of the given id", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.Members.get()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
      end)

      assert %Member{
               id: 2666,
               name: "John Doe",
               archived: false,
               capacity: 8.0,
               email: "john.doe@example.org",
               freelancer: false,
               joined_at: "2019-01-01",
               avatar: %Avatar{
                 url: "/default_avatar/user/2666.svg",
                 medium: %{url: "/default_avatar/user/2666.svg"},
                 small: %{url: "/default_avatar/user/2666.svg"},
                 thumb: %{url: "/default_avatar/user/2666.svg"}
               }
             } = Members.get_member!(2666, config)
    end

    test "returns nil when the id does not exist", %{bypass: bypass, config: config} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "")
      end)

      assert_raise RuntimeError, "Can't find a member with ID 1", fn ->
        Members.get_member!(1, config)
      end
    end
  end

  describe "list_active_members/1" do
    test "returns a list of members", %{bypass: bypass, config: config} do
      expected_response = GlassFactoryApi.Fixtures.Members.list()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, expected_response)
      end)

      assert {:ok,
              [
                %Member{
                  id: 2666,
                  name: "John Doe",
                  archived: false,
                  capacity: 8.0,
                  email: "john.doe@example.org",
                  freelancer: false,
                  joined_at: "2019-01-01"
                }
              ]} == Members.list_active_members(config)
    end
  end

  describe "list_active_members!/1" do
    test "returns a list of members", %{bypass: bypass, config: config} do
      request_response = GlassFactoryApi.Fixtures.Members.list()

      Bypass.expect_once(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, request_response)
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
             ] == Members.list_active_members!(config)
    end
  end
end

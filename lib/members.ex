defmodule GlassFactoryApi.Members do
  @moduledoc """
  Provides the methods to list members of an organization.
  """
  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.Members.Member

  @doc """
  List the members of a organization

  ## Examples

      iex> GlassFactoryApi.Members.list_members()
      [ %Member{
          name: "John Doe",
          email: "john.doe@example.org",
          id: 0,
          archived: false,
          capacity: 8.0,
          freelancer: false,
          joined_at: "2019-01-01"
        }
      ]
  """
  @spec list_members() :: list(Member.t())
  def list_members(config \\ %{}) do
    {:ok, %{status: 200, body: body}} = ApiClient.get("members", config)

    body
    |> Enum.map(&Member.to_struct(&1))
  end

  @doc """
  Get a member given the id

  ## Examples

      iex> GlassFactoryApi.Members.get_member("123")
      %Member{
         name: "John Doe",
         email: "john.doe@example.org",
         id: 0,
         archived: false,
         capacity: 8.0,
         freelancer: false,
         joined_at: "2019-01-01"
      }
  """
  @spec get_member(String.t()) :: Member.t() | nil
  def get_member(member_id, config \\ %{}) do
    case ApiClient.get("members/#{member_id}", config) do
      {:ok, %{status: 200, body: body}} ->
        body
        |> Member.to_struct()

      {:ok, %{status: 404}} ->
        nil
    end
  end
end

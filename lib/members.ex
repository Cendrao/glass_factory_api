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
  def list_members() do
    {:ok, %{status_code: 200, body: body}} = ApiClient.get("members")

    body
    |> Jason.decode!()
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
  def get_member(member_id) do
    case ApiClient.get("members/#{member_id}") do
      {:ok, %{status_code: 200, body: body}} ->
        body
        |> Jason.decode!()
        |> Member.to_struct()

      {:error, %{status_code: 404}} ->
        nil
    end
  end
end

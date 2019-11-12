defmodule GlassFactoryApi.Clients do
  @moduledoc """
  Provides the methods to list clients of an organization.
  """
  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.Clients.Client

  @doc """
  Get a client given the id

  ## Examples

      iex> GlassFactoryApi.Clients.get_client("1234")
      %Client{
        id: 1234,
        name: "Google",
        archived_at: null,
        owner_id: 567,
        office_id: 789
      }
  """
  @spec get_client(integer(), map) :: nil | GlassFactoryApi.Clients.Client.t()
  def get_client(client_id, config \\ %{}) do
    case ApiClient.get("clients/#{client_id}", config) do
      {:ok, %{status: 200, body: body}} ->
        body
        |> Client.to_struct()

      {:ok, %{status: 404}} ->
        nil
    end
  end
end

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
  @spec get_client(integer(), map) :: {atom(), Client.t() | String.t()}
  def get_client(client_id, config \\ %{}) do
    with {:ok, %{status: 200, body: body}} <- ApiClient.get("clients/#{client_id}", config) do
      {:ok, Client.to_struct(body)}
    else
      {:ok, %{status: 404}} -> {:error, "Can't find a client with id #{client_id}"}
    end
  end

  def get_client!(client_id, config \\ %{}) do
    with {:ok, client} <- get_client(client_id, config) do
      client
    else
      {:error, error} -> raise error
    end
  end
end

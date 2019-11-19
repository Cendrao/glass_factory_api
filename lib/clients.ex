defmodule GlassFactoryApi.Clients do
  @moduledoc """
  Provides the methods to list clients of an organization.
  """
  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.Clients.Client

  @doc """
  Return a tuple with `:ok` atom and the client from the specified ID
  or an tuple with `:error` and a string with the error description.

  ## Examples

  iex> GlassFactoryApi.Clients.get_client("1234")
  {:ok,
    %Client{
      id: 1234,
      name: "Google",
      archived_at: null,
      owner_id: 567,
      office_id: 789
    }
  }


  iex> GlassFactoryApi.Clients.get_client("1")
  {:error, "Can't find a client with id 1"}
  """
  @spec get_client(integer(), map) :: {atom(), Client.t() | String.t()}
  def get_client(client_id, config \\ %{}) do
    with {:ok, %{status: 200, body: body}} <- ApiClient.get("clients/#{client_id}", config) do
      {:ok, Client.to_struct(body)}
    else
      {:ok, %{status: 404}} -> {:error, "Can't find a client with id #{client_id}"}
      {:ok, %{body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Return the client from the specified ID
  or raises an error.

  ## Examples

  iex> GlassFactoryApi.Clients.get_client("1234")
  %Client{
    id: 1234,
    name: "Google",
    archived_at: null,
    owner_id: 567,
    office_id: 789
  }


  iex> GlassFactoryApi.Clients.get_client("1")
  "Can't find a client with id 1"
  """
  @spec get_client!(integer(), map) :: {Client.t()}
  def get_client!(client_id, config \\ %{}) do
    with {:ok, client} <- get_client(client_id, config) do
      client
    else
      {:error, error} -> raise error
    end
  end

  @doc """
  Return a tuple with `:ok` atom and all clients from an account or an tuple with `:error` and a string with the error
  description.

  ## Examples

  iex> GlassFactoryApi.Clients.list_clients()
  {:ok,
    [
      %Client{
        id: 1234,
        name: "Google",
        archived_at: null,
        owner_id: 567,
        office_id: 789
      },
      %Client{
        id: 1235,
        name: "Facebook",
        archived_at: null,
        owner_id: 567,
        office_id: 789
      }
    ]
  }

  iex> GlassFactoryApi.Clients.list_clients()
  {:error, "econnrefused"}
  """

  @spec list_clients(map()) :: {atom(), [Client.t()] | String.t()}
  def list_clients(config) do
    with {:ok, %{status: 200, body: body}} <- ApiClient.get("clients", config) do
      {:ok, Enum.map(body, &Client.to_struct(&1))}
    else
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Return a list with all clients from an account or raises an error.

  ## Examples

    iex> GlassFactoryApi.Clients.list_clients!()
    [
      %Client{
        id: 1234,
        name: "Google",
        archived_at: null,
        owner_id: 567,
        office_id: 789
      },
      %Client{
        id: 1235,
        name: "Facebook",
        archived_at: null,
        owner_id: 567,
        office_id: 789
      }
    ]

    iex> GlassFactoryApi.Clients.list_clients!()
    "econnrefused"
  """

  @spec list_clients!(map()) :: {[Client.t()]}
  def list_clients!(config) do
    with {:ok, clients} <- list_clients(config) do
      clients
    else
      {:error, error} -> raise error
    end
  end
end

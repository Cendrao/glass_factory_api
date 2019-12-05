defmodule GlassFactoryApi.Organization do
  @moduledoc """
  Defines functions to get entities at Organization level such as Roles.
  """

  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.Organization.Role

  @doc """
  Return a tuple with `:ok` atom and a list of organization's roles, or a tuple with `:error` and a message with the error description.

  ## Examples

      iex> GlassFactoryApi.Organization.list_roles()
      {:ok, [ %Role{
            id: 1234,
            name: "partner",
            description: "Partner",
            archived: false
          }
        ]
      }

      iex> GlassFactoryApi.Organization.list_roles()
      {:error, "econnrefused"}
  """
  @spec list_roles(map) :: {atom, list(Role.t()) | String.t()}
  def list_roles(config) do
    with {:ok, %{status: 200, body: body}} <-
           ApiClient.get("roles", config) do
      {:ok, Enum.map(body, &Role.to_struct/1)}
    else
      {:ok, %{body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Return a list of organization's roles, or raises if something went wrong.

  ## Examples

      iex> GlassFactoryApi.Organization.list_roles!()
      [ %Role{
        id: 1234,
        name: "partner",
        description: "Partner",
        archived: false
        }
      ]

      iex> GlassFactoryApi.Organization.list_roles!()
      ** (RuntimeError) econnrefused
  """
  @spec list_roles!(map) :: list(Role.t())
  def list_roles!(config) do
    with {:ok, roles} <- list_roles(config) do
      roles
    else
      {:error, error} -> raise error
    end
  end
end

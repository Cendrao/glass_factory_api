defmodule GlassFactoryApi.Members do
  @moduledoc """
  Provides the methods to list members of an organization.
  """
  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.Members.Member

  @doc """
  Returns a list with organization's members or `:error` if something went wrong.

  If the request returns successfully then `{:ok, [%Member{}]}` will be returned, but if something went wrong a tuple with `:error` and a message will be returned.

  ## Examples

      iex> GlassFactoryApi.Members.list_members()
      {:ok, [ %Member{
            name: "John Doe",
            email: "john.doe@example.org",
            id: 0,
            archived: false,
            capacity: 8.0,
            freelancer: false,
            joined_at: "2019-01-01"
          }
        ]
      }

      iex> GlassFactoryApi.Members.list_members()
      {:error, "econnrefused"}
  """
  @spec list_members(map()) :: {atom(), list(Member.t()) | String.t()}
  def list_members(config \\ %{}) do
    with {:ok, %{status: 200, body: body}} <- ApiClient.get("members", config) do
      {:ok, Enum.map(body, &Member.to_struct(&1))}
    else
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Returns a list with organization's members or raises if something went wrong.

  If the request returns successfully then a list of `%Member{}` will be returned, raises if something went wrong.

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

      iex> GlassFactoryApi.Members.list_members()
      ** (RuntimeError) econnrefused
  """
  @spec list_members!(map()) :: list(Member.t())
  def list_members!(config \\ %{}) do
    with {:ok, members} <- list_members(config) do
      members
    else
      {:error, error} -> raise error
    end
  end

  @doc """
  Returns the project given the id or `:error` with a message if something went wrong.

  ## Examples

      iex> GlassFactoryApi.Members.get_member("123")
      {:ok, %Member{
          name: "John Doe",
          email: "john.doe@example.org",
          id: 0,
          archived: false,
          capacity: 8.0,
          freelancer: false,
          joined_at: "2019-01-01"
        }
      }

      iex> GlassFactoryApi.Members.get_member("123")
      {:error, "Can't find a member with ID 123"}
  """
  @spec get_member(String.t(), map()) :: {atom(), Member.t() | String.t()}
  def get_member(member_id, config \\ %{}) do
    with {:ok, %{status: 200, body: body}} <- ApiClient.get("members/#{member_id}", config) do
      {:ok, Member.to_struct(body)}
    else
      {:ok, %{status: 404}} -> {:error, "Can't find a member with ID #{member_id}"}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Returns the project given the id or raises if something went wrong.

  ## Examples

      iex> GlassFactoryApi.Members.get_member("123")
      {:ok, %Member{
          name: "John Doe",
          email: "john.doe@example.org",
          id: 0,
          archived: false,
          capacity: 8.0,
          freelancer: false,
          joined_at: "2019-01-01"
        }
      }

      iex> GlassFactoryApi.Members.get_member("123")
      ** (RuntimeError) "Can't find a member with ID 123"
  """
  @spec get_member!(String.t(), map()) :: Member.t()
  def get_member!(member_id, config \\ %{}) do
    with {:ok, member} <- get_member(member_id, config) do
      member
    else
      {:error, error} -> raise error
    end
  end

  @doc """
  Returns the active members from an organization.

  ## Examples

      iex> GlassFactoryApi.Members.list_active_members()
      {:ok, [ %Member{
            name: "John Doe",
            email: "john.doe@example.org",
            id: 0,
            archived: false,
            capacity: 8.0,
            freelancer: false,
            joined_at: "2019-01-01"
          }
        ]
      }

      iex> GlassFactoryApi.Members.list_members()
      {:error, "econnrefused"}
  """
  @spec list_active_members(map()) :: {atom, list(Member)}
  def list_active_members(config \\ %{}) do
    with {:ok, %{status: 200, body: body}} <- ApiClient.get("members/active", config) do
      {:ok, Enum.map(body, &Member.to_struct(&1))}
    else
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Returns the active members from an organization. It raises if something went wrong.

  ## Examples

      iex> GlassFactoryApi.Members.list_active_members!()
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

      iex> GlassFactoryApi.Members.list_members!()
      ** (RuntimeError) econnrefused
  """
  @spec list_active_members!(map()) :: list(Member)
  def list_active_members!(config \\ %{}) do
    with {:ok, active_members} <- list_active_members(config) do
      active_members
    else
      {:error, error} -> raise error
    end
  end
end

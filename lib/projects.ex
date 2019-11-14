defmodule GlassFactoryApi.Projects do
  @moduledoc """
  Provides the methods to list projects of an organization.
  """

  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.Projects.Project

  @doc """
  Returns a list with organization's projects or `:error` if something went wrong.

  If the request returns successfully then `{:ok, [%Project{}]}` will be returned, but if something went wrong `:error` is returned along with a message.

  ## Examples

      iex> GlassFactoryApi.Projects.list_projects()
      {:ok, [ %Project{
            name: "Big project",
            id: 123,
            archived: false...
          }
        ]
      }

      iex> GlassFactoryApi.Projects.list_projects()
      {:error, :econnrefused}
  """
  @spec list_projects(map()) :: {atom(), list(Project.t())}
  def list_projects(config \\ %{}) do
    case ApiClient.get("projects", config) do
      {:ok, %{status: 200, body: body}} -> {:ok, Enum.map(body, &Project.to_struct(&1))}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Returns a list with organization's projects or raises if something went wrong.

  If the request returns successfully then `{:ok, [%Project{}]}` will be returned, but if something went wrong raises an error.

  ## Examples

      iex> GlassFactoryApi.Projects.list_projects!()
      [ %Project{
            name: "Big project",
            id: 123,
            archived: false...
          }
      ]

      iex> GlassFactoryApi.Projects.list_projects!()
      ** (RuntimeError) econnrefused
  """
  def list_projects!(config \\ %{}) do
    with {:ok, projects} <- list_projects(config) do
      projects
    else
      {:error, error} -> raise error
    end
  end

  @doc """
  Returns the project given the id or `:error` if something went wrong.

  If the request returns successfully then `{:ok, %Project{}}` should be returned, but if something went wrong `:error` is returned along with a message.

  ## Examples

      iex> GlassFactoryApi.Projects.get_project("123")
      {:ok, %Project{
          name: "Big project",
          id: "123",
          archived: false...
        }
      }

      iex> GlassFactoryApi.Projects.get_project("999")
      {:error, "Can't find a project with ID 999"}
  """
  @spec get_project(String.t(), map()) :: {atom(), Project.t() | atom()}
  def get_project(project_id, config \\ %{}) do
    case ApiClient.get("projects/#{project_id}", config) do
      {:ok, %{status: 200, body: body}} -> {:ok, Project.to_struct(body)}
      {:ok, %{status: 404}} -> {:error, "Can't find a project with ID #{project_id}"}
      {:ok, %{body: body}} -> {:error, body}
      {:error, error} -> error
    end
  end

  @doc """
  Returns the project given the id or raises an error if something went wrong.

  Same of `get_project\2` but raises instead of returning a tuple with `:error`

  ## Examples

      iex> GlassFactoryApi.Projects.get_project!("123")
      %Project{
        name: "Big project",
        id: "123",
        archived: false...
      }

      iex> GlassFactoryApi.Projects.get_project!("999")
      ** (ArgumentError) Can't find a project with 999
  """
  def get_project!(project_id, config \\ %{}) do
    with {:ok, project} <- get_project(project_id, config) do
      project
    else
      {:error, error} -> raise error
    end
  end
end

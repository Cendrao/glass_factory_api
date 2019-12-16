defmodule GlassFactoryApi.Projects.Activities do
  @moduledoc """
  Provides the methods to list project activities of an organization.
  """
  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.Activities.Activity

  @doc """
  Return a tuple with `:ok` atom and the activities from the specified project ID
  or an tuple with `:error` and a string with the error description.

  ## Examples

      iex> GlassFactoryApi.Projects.Activities.list_activities("1234")
      {:ok,
        [
          %Activity{
            id: 1122,
            name: "General Time"
          },
          %Activity{
            id: 1123,
            name: "Mobile App"
          },
          %Activity{
            id: 1124,
            name: "Integrations"
          }
        ]
      }

      iex> GlassFactoryApi.Projects.Activities.list_activities("1")
      {:error, "Can't find activities for project id 1"}
  """
  @spec list_activities(integer(), map) :: {atom(), [Activity.t()] | String.t()}
  def list_activities(project_id, config \\ %{}) do
    request = ApiClient.get("projects/#{project_id}/activities", config)

    with {:ok, %{status: 200, body: body}} <- request do
      {:ok, Enum.map(body, &Activity.to_struct/1)}
    else
      {:ok, %{status: 404}} -> {:error, "Can't find activities for project id #{project_id}"}
      {:ok, %{body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Return the activities from the specified project ID
  or raises an error.

  ## Examples

  iex> GlassFactoryApi.Projects.Activities.list_activities!("1234")
  %Activity{
    id: 1122,
    name: "General Time"
  }

  iex> GlassFactoryApi.Projects.Activities.list_activities!("999")
  ** (RuntimeError) econnrefused
  """
  @spec list_activities!(integer(), map) :: [Activity.t()]
  def list_activities!(project_id, config \\ %{}) do
    with {:ok, activities} <- list_activities(project_id, config) do
      activities
    else
      {:error, error} -> raise error
    end
  end
end

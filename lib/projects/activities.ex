defmodule GlassFactoryApi.Projects.Activities do
  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.Activities.Activity

  def list_activities(project_id, config \\ %{}) do
    request = ApiClient.get("projects/#{project_id}/activities", config)

    with {:ok, %{status: 200, body: body}} <- request do
      {:ok, Enum.map(body, &Activity.to_struct/1)}
    else
      {:ok, %{status: 404}} -> {:error, "Can't find a activities for project id #{project_id}"}
      {:ok, %{body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  def list_activities!(project_id, config \\ %{}) do
    with {:ok, activities} <- list_activities(project_id, config) do
      activities
    else
      {:error, error} -> raise error
    end
  end
end

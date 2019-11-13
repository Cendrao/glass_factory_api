defmodule GlassFactoryApi.Projects.Project do
  @moduledoc """
  Defines the Project of organization.
  """

  alias GlassFactoryApi.Projects.Project

  @type t() :: %Project{
          archived: boolean(),
          billable_status: String.t(),
          client_id: String.t(),
          closed: boolean(),
          closed_at: String.t() | nil,
          created_at: String.t(),
          enable_general_time: boolean(),
          id: String.t(),
          job_id: String.t(),
          manager_id: String.t(),
          name: String.t(),
          office_id: String.t(),
          pricing: map(),
          probability: integer(),
          probability_state: String.t(),
          sequental_id: String.t(),
          url: String.t()
        }

  defstruct [
    :archived,
    :billable_status,
    :client_id,
    :closed,
    :closed_at,
    :created_at,
    :enable_general_time,
    :id,
    :job_id,
    :manager_id,
    :name,
    :office_id,
    :pricing,
    :probability,
    :probability_state,
    :sequental_id,
    :url
  ]

  @doc """
  Parse a map into a Project struct

  ## Examples

      iex> GlassFactoryApi.Project.to_struct(%{name: "Big project", id: "123" archived: false})
      %Project{
         name: "Big project",
         id: "123",
         archived: false...
      }
  """
  def to_struct(attrs) do
    %Project{
      archived: attrs["archived"],
      billable_status: attrs["billable_status"],
      client_id: attrs["client_id"],
      closed: attrs["closed"],
      closed_at: attrs["closed_at"],
      created_at: attrs["created_at"],
      enable_general_time: attrs["enable_general_time"],
      id: attrs["id"],
      job_id: attrs["job_id"],
      manager_id: attrs["manager_id"],
      name: attrs["name"],
      office_id: attrs["office_id"],
      pricing: attrs["pricing"],
      probability: attrs["probability"],
      probability_state: attrs["probability_state"],
      sequental_id: attrs["sequental_id"],
      url: attrs["url"]
    }
  end
end

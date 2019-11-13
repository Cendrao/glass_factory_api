defmodule GlassFactoryApi.Clients.Reports.TimeReport do
  @moduledoc """
  Defines the TimeReport of a client report.
  """
  alias GlassFactoryApi.Clients.Reports.TimeReport

  @type t() :: %TimeReport{
          client_id: integer(),
          project_id: integer(),
          job_id: integer() | nil,
          activity_id: integer() | nil,
          user_id: integer(),
          role_id: integer(),
          date: String.t(),
          planned: integer(),
          time: integer()
        }

  defstruct [
    :client_id,
    :project_id,
    :job_id,
    :activity_id,
    :user_id,
    :role_id,
    :date,
    :planned,
    :time
  ]

  @doc """
  Parse a map into a TimeReport struct

  ## Examples

      iex> GlassFactoryApi.Clients.Reports.TimeReport(%{client_id: 2079, project_id: 14330...})
      %TimeReport{
        client_id: 2079,
        project_id: 14330,
        job_id: nil,
        activity_id: nil,
        user_id: 3,
        role_id: 1480,
        date: "2018-07-10",
        planned: 8,
        time: 0
      }
  """
  def to_struct(attrs) do
    %TimeReport{
      client_id: attrs["client_id"],
      project_id: attrs["project_id"],
      job_id: attrs["job_id"],
      activity_id: attrs["activity_id"],
      user_id: attrs["user_id"],
      role_id: attrs["role_id"],
      date: attrs["date"],
      planned: attrs["planned"],
      time: attrs["time"]
    }
  end
end

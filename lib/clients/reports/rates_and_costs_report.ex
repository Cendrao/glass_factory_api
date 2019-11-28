defmodule GlassFactoryApi.Clients.Reports.RatesAndCostsReport do
  @moduledoc """
  Defines the RatesAndCostsReport of a client report.
  """
  alias GlassFactoryApi.Clients.Reports.RatesAndCostsReport

  @type t() :: %RatesAndCostsReport{
          client_id: integer(),
          project_id: integer(),
          job_id: integer(),
          activity_id: integer(),
          user_id: integer(),
          role_id: integer(),
          date: String.t(),
          time: integer(),
          rate: integer(),
          cost: integer()
        }

  defstruct [
    :client_id,
    :project_id,
    :job_id,
    :activity_id,
    :user_id,
    :role_id,
    :date,
    :time,
    :rate,
    :cost
  ]

  @doc """
  Parse a map into a RatesAndCostsReport struct

  ## Examples

      iex> GlassFactoryApi.Clients.Reports.RatesAndCostsReport(%{client_id: 1234, project_id: 12345...})
      %RatesAndCostsReport{
        client_id: 1234,
        project_id: 12345,
        job_id: nil,
        activity_id: 123_456,
        user_id: 222,
        role_id: 1234,
        date: "2018-06-19",
        time: 8,
        rate: 35,
        cost: 35
      }
  """
  def to_struct(attrs) do
    %RatesAndCostsReport{
      client_id: attrs["client_id"],
      project_id: attrs["project_id"],
      job_id: attrs["job_id"],
      activity_id: attrs["activity_id"],
      user_id: attrs["user_id"],
      role_id: attrs["role_id"],
      date: attrs["date"],
      time: attrs["time"],
      rate: attrs["rate"],
      cost: attrs["cost"]
    }
  end
end

defmodule GlassFactoryApi.Clients.Reports do
  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.Clients.Reports.TimeReport

  @doc """
  List time reports from the given client id

  ## Examples

      iex> GlassFactoryApi.Clients.Reports.list_time_reports(2079)
      [:ok, %TimeReport{
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
      ]
  """
  @spec list_time_reports(integer(), map()) :: {:error, String.t()} | {:ok, [TimeReport.t()]}
  def list_time_reports(client_id, config \\ %{}) do
    client_request = ApiClient.get("clients/#{client_id}/reports/time", config)

    with {:ok, %{status: 200, body: body}} <- client_request do
      time_reports = Enum.map(body, &TimeReport.to_struct(&1))

      {:ok, time_reports}
    else
      {:ok, %{status: 404}} -> {:error, "Can't find time reports for client id #{client_id}"}
      {:ok, %{body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  List time reports from the given client id or raises an error if something went wrong.

  Same of `list_time_reports\2` but raises instead of returning a tuple with `:error`

  ## Examples

      iex> GlassFactoryApi.Clients.Reports.list_time_reports!(2079)
      [ %TimeReport{
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
      ]

      iex> GlassFactoryApi.Clients.Reports.list_time_reports!(999)
      ** (RuntimeError) Can't find time reports for client id 999
  """
  @spec list_time_reports!(integer, map) :: [TimeReport.t()]
  def list_time_reports!(client_id, config \\ %{}) do
    with {:ok, time_reports} <- list_time_reports(client_id, config) do
      time_reports
    else
      {:error, message} -> raise message
    end
  end
end

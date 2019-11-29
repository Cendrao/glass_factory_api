defmodule GlassFactoryApi.Clients.Reports do
  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.Clients.Reports.TimeReport

  @moduledoc """
  Provides function that get client reports from GlassFactory
  """

  @type parameters() :: [
          start: String.t(),
          end: String.t(),
          user_id: String.t(),
          date: String.t(),
          project_id: String.t()
        ]

  @doc """
  List time reports from the given client id

  ## Examples

      iex> GlassFactoryApi.Clients.Reports.list_time_reports(2079, [start: ~D[2019-01-01]])
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
  @spec list_time_reports(integer, parameters, map) ::
          {:error, String.t()} | {:ok, [TimeReport.t()]}
  def list_time_reports(client_id, opts \\ [], config \\ %{}) do
    client_request = ApiClient.get("clients/#{client_id}/reports/time", filter_opts(opts), config)

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

      iex> GlassFactoryApi.Clients.Reports.list_time_reports!(2079, [start: ~D[2019-01-01]])
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
  @spec list_time_reports!(integer, parameters, map) :: [TimeReport.t()]
  def list_time_reports!(client_id, opts \\ [], config \\ %{}) do
    with {:ok, time_reports} <- list_time_reports(client_id, opts, config) do
      time_reports
    else
      {:error, message} -> raise message
    end
  end

  defp filter_opts(opts) do
    Keyword.take(opts, [:start, :end, :user_id, :date, :project_id])
  end
end

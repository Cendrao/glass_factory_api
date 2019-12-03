defmodule GlassFactoryApi.Clients.Reports do
  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.Clients.Reports.{TimeReport, RatesAndCostsReport}

  @moduledoc """
  Provides function that get client reports from GlassFactory
  """

  @type parameters() :: [
          start: String.t(),
          end: String.t(),
          user_id: String.t(),
          date: Date.t(),
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

  @doc """
  List rates and costs reports from the given client id

  ## Examples

      iex> GlassFactoryApi.Clients.Reports.list_rates_and_costs_reports(1234, [], config)
      {:ok, [%RatesAndCostsReport{
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
        }]
      }
  """
  @spec list_rates_and_costs_reports(integer(), Keyword.t(), map) ::
          {:error, any} | {:ok, [RatesAndCostsReport]}
  def list_rates_and_costs_reports(client_id, opts \\ [], config \\ %{}) do
    client_request =
      ApiClient.get("clients/#{client_id}/reports/money", filter_opts(opts), config)

    with {:ok, %{status: 200, body: body}} <- client_request do
      rates_and_costs_reports = Enum.map(body, &RatesAndCostsReport.to_struct/1)

      {:ok, rates_and_costs_reports}
    else
      {:ok, %{status: 404}} ->
        {:error, "Can't find rates and costs reports for client id #{client_id}"}

      {:ok, %{body: body}} ->
        {:error, body}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  List rates and costs reports from the given client id or raises an error if something went wrong.

  Same of `list_rates_and_costs_reports/3` but raises instead of returning a tuple with `:error`

  ## Examples

      iex> GlassFactoryApi.Clients.Reports.list_rates_and_costs_reports!(1234, [], config)
      [ %RatesAndCostsReport{
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
      ]

      iex> GlassFactoryApi.Clients.Reports.list_rates_and_costs_reports!(999)
      ** (RuntimeError) Can't find rates and costs reports for client id 999
  """
  @spec list_rates_and_costs_reports!(integer(), Keyword.t(), map) :: [RatesAndCostsReport]
  def list_rates_and_costs_reports!(client_id, opts \\ [], config \\ %{}) do
    with {:ok, rates_and_costs_reports} <- list_rates_and_costs_reports(client_id, opts, config) do
      rates_and_costs_reports
    else
      {:error, message} -> raise message
    end
  end

  defp filter_opts(opts) do
    Keyword.take(opts, [:start, :end, :user_id, :date, :project_id])
  end
end

defmodule GlassFactoryApi.NonWorkingDays do
  @moduledoc """
  Provides functions to get non working days.
  """

  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.NonWorkingDays.NonWorkingDay

  @doc """
  Receives a keyword list and a map. The first are options to filter the non working days and the second are http
  request options.

  Returns a tuple with `:ok` atom and a list of %NonWorkingDay
  or a tuple with `:error` and a string with the error description.

  ## Params

  The supported filters are
    * `start` (date yyyy-mm-dd) - to filter the non working days from a period.
    * `end` (date yyyy-mm-dd) - to filter the non working days up untial a period.
    * `office_id` (positive integer) - to filter the non working days of a specific office.

  If you use the start filter, you need to use the end filter too.

  ## Examples

      iex> GlassFactoryApi.NonWorkingDays.get_non_working_days()
      {
        :ok,
        [
          %NonWorkingDay{
            id: 102,
            start_date: "2017-07-04",
            end_date: "2017-07-04",
            name: "Independence Day",
            office_id: 101
          },
          %NonWorkingDay{
            id: 103,
            start_date: "2017-12-25",
            end_date: "2017-12-25",
            name: "Christmas Day",
            office_id: 101
          }
        ]
      }

      iex> GlassFactoryApi.NonWorkingDays.get_non_working_days([start: '2019-10-01', '2019-10-31'])
      {
        :ok,
        []
      }

      iex> GlassFactoryApi.NonWorkingDays.get_non_working_days()
      {:error, "econnrefused"}
  """
  @spec get_non_working_days(Keyword.t(), map()) :: {atom(), [NonWorkingDay.t() | String.t()]}
  def get_non_working_days(query \\ [], config \\ %{}) do
    with {:ok, %{status: 200, body: body}} <-
           ApiClient.get("non_working_days", filter_query_string(query), config) do
      {:ok, Enum.map(body, &NonWorkingDay.to_struct/1)}
    else
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Similar to get_non_working_days\2, the params is the same. What is different is the return:

  This function returns a list of %NonWorkingDay or raises an error.
  """
  def get_non_working_days!(query \\ [], config \\ %{}) do
    with {:ok, non_working_days} <- get_non_working_days(query, config) do
      non_working_days
    else
      {:error, error} -> raise error
    end
  end

  defp filter_query_string(query_string) do
    Keyword.take(query_string, [:start, :end, :office_id])
  end
end

defmodule GlassFactoryApi.Vacations do
  @moduledoc """
  Provides functions to get vacations of all or a specific user.
  """

  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.Vacations.Vacation

  @doc """
  Return a tuple with `:ok` atom and an list of vacations.
  or a tuple with `:error` and a string with the error description.

  It's possible apply some filters, like user_id, start and end to limit dates, and vacation_type
  using the query_string param.

  ## Arguments

  - query_string - options to filter the vacations.

    ## Options
    * `user_id` (positive integer) - to return only the vacations from the user id specified.
    * `start` (date yyyy-mm-dd) - to filter the vacations from a period.
    * `end` (date yyyy-mm-dd) - to filter the vacations up until a period.


    If you use start, you need to use end options too.

  - config - configurations for HTTP request

  ## Examples

  iex> GlassFactoryApi.Clients.get_vacations()
  {:ok,
    [
      %Vacation{
        id: 119,
        upcoming: false,
        daily_hours: 8,
        start_date: "2017-07-24",
        end_date: "2017-07-30",
        days: 7,
        vacation_type: "paid",
        creator_id: 722,
        user_id: 722,
      },
      %Vacation{
        id: 132,
        upcoming: false,
        daily_hours: 8,
        start_date: "2019-07-20",
        end_date: "2019-07-30",
        days: 10,
        vacation_type: "paid",
        creator_id: 734,
        user_id: 734
      }
    ]
  }

  iex> GlassFactoryApi.Clients.get_vacations([user_id: 734, start: 2019-07-01, end: 2019-07-31])
  {:ok,
    [
      %Vacation{
        id: 132,
        upcoming: false,
        daily_hours: 8,
        start_date: "2019-07-20",
        end_date: "2019-07-30",
        days: 10,
        vacation_type: "paid",
        creator_id: 734,
        user_id: 734
      }
    ]
  }

  iex> GlassFactoryApi.Clients.get_vacations("1")
  {:ok, []}
  """

  @spec get_vacations(Keyword.t(), map()) :: {atom(), [Vacation.t() | String.t()]}
  def get_vacations(query_string \\ [], config \\ %{}) do
    with {:ok, %{status: 200, body: body}} <- ApiClient.get("vacations", filter_query_string(query_string), config) do
      {:ok, Enum.map(body, &Vacation.to_struct/1)}
    else
      {:ok, %{status: 404}} -> {:error, "Vacations not found"}
      {:ok, %{body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Similar to get_vacation/2, returns a list of vacations or raises an error.

  ## Arguments

  - query_string - options to filter the vacations.

    ## Options
    * `user_id` (positive integer) - to return only the vacations from the user id specified.
    * `start` (date yyyy-mm-dd) - to filter the vacations from a period.
    * `end` (date yyyy-mm-dd) - to filter the vacations up until a period.


    If you use start, you need to use end options too.

  - config - configurations for HTTP request

  ## Examples

      iex> GlassFactoryApi.Clients.get_vacations!()
      [
        %Vacation{
          id: 119,
          upcoming: false,
          daily_hours: 8,
          start_date: "2017-07-24",
          end_date: "2017-07-30",
          days: 7,
          vacation_type: "paid",
          creator_id: 722,
          user_id: 722,
        },
        %Vacation{
          id: 132,
          upcoming: false,
          daily_hours: 8,
          start_date: "2019-07-20",
          end_date: "2019-07-30",
          days: 10,
          vacation_type: "paid",
          creator_id: 734,
          user_id: 734
        }
      ]

      iex> GlassFactoryApi.Clients.get_vacations!([user_id: 734, start: 2019-07-01, end: 2019-07-31])
      [
        %Vacation{
          id: 132,
          upcoming: false,
          daily_hours: 8,
          start_date: "2019-07-20",
          end_date: "2019-07-30",
          days: 10,
          vacation_type: "paid",
          creator_id: 734,
          user_id: 734
        }
      ]

      iex> GlassFactoryApi.Clients.get_vacations!("1")
      []
  """

  @spec get_vacations!([], map()) :: [Vacation.t()]
  def get_vacations!(filters \\ [], config \\ %{}) do
    with {:ok, vacations} <- get_vacations(filters, config) do
      vacations
    else
      {:error, error} -> raise error
    end
  end

  defp filter_query_string(query_string) do
    Keyword.take(query_string, [:start, :end, :user_id, :vacation_type])
  end
end

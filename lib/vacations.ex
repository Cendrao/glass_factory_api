defmodule GlassFactoryApi.Vacations do
  @moduledoc """
  Provides the methods to get vacations of all or a specific user.
  """

  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.Vacations.Vacation

  @doc """
  Return a tuple with `:ok` atom and an list of vacations.
  or an tuple with `:error` and a string with the error description.

  It's possible apply some filters, like user_id, start and end to limit dates, and vacation_type
  using the query_string param.

  ## Examples

  iex> GlassFactoryApi.Clients.get_vacation()
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

  iex> GlassFactoryApi.Clients.get_vacation([user_id: 734, start: 2019-07-01, end: 2019-07-31])
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

  iex> GlassFactoryApi.Clients.get_vacation("1")
  {:ok, []}
  """

  def get_vacations(query_string \\ [], config \\ %{}) do
    with {:ok, %{status: 200, body: body}} <- ApiClient.get("vacations", query_string, config) do
      {:ok, Enum.map(body, &Vacation.to_struct(&1))}
    else
      {:ok, %{status: 404}} -> {:error, "Vacations not found"}
      {:ok, %{body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  def get_vacations!(query_string \\ [], config \\ %{}) do
    with {:ok, vacations} <- get_vacations(query_string, config) do
      vacations
    else
      {:error, error} -> raise error
    end
  end
end

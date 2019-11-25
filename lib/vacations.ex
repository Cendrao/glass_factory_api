defmodule GlassFactoryApi.Vacations do
  @moduledoc """

  """

  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.Vacations.Vacation

  @doc """

  """

  def get_vacations(query_string \\ [], config \\ %{}) do
    with {:ok, %{status: 200, body: body}} <- ApiClient.get("vacations", query_string, config) do
      {:ok, Enum.map(body, &Vacation.to_struct(&1))}
    else
      {:ok, %{status: 404}} -> {:error, "Vacations not founded"}
    end
  end
end

defmodule GlassFactoryApi.Vacations do
  @moduledoc """

  """

  alias GlassFactoryApi.ApiClient
  alias GlassFactoryApi.Vacations.Vacation

  @doc """

  """

  def get_vacations(user_id \\ nil, config \\ %{}) do
    with {:ok, %{status: 200, body: body}} <- ApiClient.get(vacations_path(user_id), config) do
      {:ok, Enum.map(body, &Vacation.to_struct(&1))}
    else
      {:ok, %{status: 404}} -> {:error, "Can't find the vacations from user id #{user_id}"}
    end
  end

  defp vacations_path(user_id) when (is_nil(user_id) or user_id == ""), do: "vacations"
  defp vacations_path(user_id), do: "vacations?user_id=#{user_id}"
end

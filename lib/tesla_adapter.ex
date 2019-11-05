defmodule GlassFactoryApi.TeslaAdapter do
  @moduledoc false

  alias GlassFactoryApi.HttpAdapter

  @behaviour HttpAdapter

  @impl HttpAdapter
  def get(path, headers) do
    case Tesla.get(path, headers: headers) do
      {:ok, %Tesla.Env{status: 200, body: body, headers: headers}} ->
        {:ok, %{status_code: 200, body: body, headers: headers}}

      {:ok, %Tesla.Env{status: status, body: body, headers: headers}} ->
        {:error, %{status_code: status, body: body, headers: headers}}

      {:error, reason} ->
        {:error, reason}
    end
  end
end

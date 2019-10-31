defmodule GlassFactoryApi.HttpoisonAdapter do
  @moduledoc """
  Adapter to HTTPoison library
  """
  alias GlassFactoryApi.HttpAdapter

  @behaviour HttpAdapter

  @impl HttpAdapter
  def get(url, headers) do
    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body, headers: headers}} ->
        {:ok, %{status_code: 200, body: body, headers: headers}}

      {:ok, %HTTPoison.Response{status_code: status_code, body: body, headers: headers}} ->
        {:error, %{status_code: status_code, body: body, headers: headers}}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end

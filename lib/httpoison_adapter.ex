defmodule GlassFactoryApi.HttpoisonAdapter do
  @moduledoc """
  Adapter to HTTPoison library
  """
  alias GlassFactoryApi.HttpAdapter

  @behaviour HttpAdapter

  @impl HttpAdapter
  def get(url, headers) do
    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: status_code, body: body, headers: headers}} ->
        {:ok, %{status_code: status_code, body: body, headers: headers}}
    end
  end
end

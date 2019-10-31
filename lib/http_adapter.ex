defmodule GlassFactoryApi.HttpAdapter do
  @moduledoc """
  Defines basic behaviours that a HttpAdapter must implement
  """

  @type response() :: %{body: String.t(), status: integer(), headers: map()}

  @doc """
  Returns the HTTP Response from a GET request with given URL and headers
  """
  @callback get(url :: String.t(), headers :: list()) :: {:ok, response()} | {:error, String.t()}
end

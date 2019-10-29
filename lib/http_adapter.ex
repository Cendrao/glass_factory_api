defmodule GlassFactoryApi.HttpAdapter do
  @type response() :: %{body: String.t(), status: integer(), headers: map()}

  @callback get(String.t(), list()) :: {:ok, response()} | {:error, String.t()}
end

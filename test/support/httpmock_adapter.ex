defmodule GlassFactoryApi.HttpmockAdapter do
  def get(_url, _headers) do
    response = %{
      status_code: 200,
      body: "{ \"description\": \"some foo json\" }",
      headers: []
    }

    {:ok, response}
  end
end

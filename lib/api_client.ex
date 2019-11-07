defmodule GlassFactoryApi.ApiClient do
  @moduledoc """
  Client which make external HTTP Request.
  """
  alias GlassFactoryApi.Configuration

  @doc """
  Make a GET request using the given configuration to retrieve the given resource.

  ## Examples
      iex> GlassFactoryApi.ApiClient.get("members")
      {:ok , %{body: "[]", headers: [], status_code: 200}}

  If no configuration is passed, it will get the default configuration which is defined in `GlassFactoryApi.Configuration.default_configuration`
  """

  @spec get(String.t(), map()) :: Tesla.Env.t()
  def get(resource, configuration) do
    config = Configuration.build(configuration)
    Tesla.get(tesla_client(config), resource)
  end

  defp tesla_client(configuration) do
    middlewares = [
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, headers(configuration)},
      {Tesla.Middleware.BaseUrl, url(configuration)}
    ]

    Tesla.client(middlewares)
  end

  defp headers(configuration) do
    [
      {"X-Account-Subdomain", configuration[:subdomain]},
      {"X-User-Token", configuration[:user_token]},
      {"X-User-Email", configuration[:user_email]},
      {"Accept", "application/json"}
    ]
  end

  defp url(configuration) do
    "#{configuration.api_url}/api/public/v1/"
  end
end

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

  If no configuration is passed, it will look for them in `Configuration.build\\1`
  If no query string is passed, no filter is applied.
  """

  @spec get(String.t(), [map()], map()) :: Tesla.Env.t()
  def get(resource, query_string \\ [], configuration) do
    config = Configuration.build(configuration)

    with {:ok, result} <- Tesla.get(tesla_client(config), resource, query: query_string) do
      {:ok, result}
    else
      {:error, error} when is_atom(error) -> {:error, Atom.to_string(error)}
      {:error, error} -> {:error, error}
    end
  end

  defp tesla_client(configuration) do
    middlewares = [
      {Tesla.Middleware.Headers, headers(configuration)},
      {Tesla.Middleware.BaseUrl, url(configuration)},
      Tesla.Middleware.JSON
    ]

    Tesla.client(middlewares)
  end

  defp headers(configuration) do
    # NOTE: We have to accept "text/plain" because when GlassFactory API returns
    # a 404 status code, it sends an invalid JSON that has JSON content-type,
    # which causes a decode error in `Tesla.Middleware.JSON`.
    [
      {"X-Account-Subdomain", configuration[:subdomain]},
      {"X-User-Token", configuration[:user_token]},
      {"X-User-Email", configuration[:user_email]},
      {"Accept", "text/plain, application/json"}
    ]
  end

  defp url(configuration) do
    "#{configuration[:api_url]}/api/public/v1/"
  end
end

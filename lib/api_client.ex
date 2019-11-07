defmodule GlassFactoryApi.ApiClient do
  @moduledoc """
  Client which make external HTTP Request.
  """

  @type http_response() :: {atom(), HttpAdapter.response()}

  @default_configuration GlassFactoryApi.Configuration.default_configuration()

  @doc """
  Make a GET request using the given configuration to retrieve the given resource.

  ## Examples
      iex> GlassFactoryApi.ApiClient.get("members")
      {:ok , %{body: "[]", headers: [], status_code: 200}}

  If no configuration is passed, it will get the default configuration which is defined in `GlassFacotryApi.Configuration.default_configuration`
  """

  @spec get(String.t(), GlassFactoryApi.Configuration.t() | nil) :: http_response()
  def get(resource, nil), do: get(resource, @default_configuration)

  def get(resource, configuration) do
    configuration.adapter.get(url(resource, configuration), headers(configuration))
  end

  defp headers(configuration) do
    [
      {"X-Account-Subdomain", configuration.subdomain},
      {"X-User-Token", configuration.user_token},
      {"X-User-Email", configuration.user_email},
      {"Accept", "application/json"}
    ]
  end

  defp url(resource, configuration) do
    "#{configuration.api_url}/api/public/v1/#{resource}"
  end
end

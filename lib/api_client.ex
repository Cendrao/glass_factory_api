defmodule GlassFactoryApi.ApiClient do
  @moduledoc """
  Client which make external HTTP Request.
  """

  @access_info Application.get_env(:glass_factory_api, GlassFactoryApi.ApiClient)

  @type http_response() :: {atom(), HttpAdapter.response()}

  @doc """
  Make a GET request using the given adapter to retrieve the given resource

  ## Examples
      iex> GlassFactoryApi.ApiClient.get("members")
      {:ok , %{body: "[]", headers: [], status_code: 200}}
  """

  @spec get(String.t()) :: http_response()
  def get(resource, adapter \\ GlassFactoryApi.HTTPoisonAdapter) do
    adapter.get(url(resource), headers())
  end

  defp headers do
    [
      "X-Account-Subdomain": @access_info[:subdomain],
      "X-User-Token": @access_info[:user_token],
      "X-User-Email": @access_info[:user_email],
      Accept: "application/json"
    ]
  end

  defp url(resource) do
    "#{api_domain()}/api/public/v1/#{resource}"
  end

  defp api_domain do
    Application.get_env(:glass_factory_api, GlassFactoryApi.ApiClient)[:api_url]
  end
end

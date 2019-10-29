defmodule GlassFactoryApi.ApiClient do
  @access_info Application.get_env(:glass_factory_api, GlassFactoryApi.ApiClient)

  def get(resource, adapter \\ GlassFactoryApi.HttpoisonAdapter) do
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
    "https://#{@access_info[:subdomain]}.glassfactory.io/api/public/v1/#{resource}"
  end
end

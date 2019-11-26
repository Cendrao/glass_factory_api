defmodule GlassFactoryApi.Configuration do
  @moduledoc """
  Defines the GlassFactoryApi configuration settings.
  """

  @doc """
  Build the configuration keys needed to make requests in GlassFactory public API

  It receives a map and evaluates if the required keys are there for make a request. If a key is missing it will first try to find in Application Variables if still missing it fill try to fetch from Environment variables.
  """
  @spec build(map()) :: map()
  def build(opts) do
    access_info = Application.get_env(:glass_factory_api, GlassFactoryApi.ApiClient)

    opts
    |> Map.put_new_lazy(:subdomain, fn ->
      access_info[:subdomain] || System.fetch_env!("GLASSFACTORY_SUBDOMAIN")
    end)
    |> Map.put_new_lazy(:user_token, fn ->
      access_info[:user_token] || System.fetch_env!("GLASSFACTORY_USER_TOKEN")
    end)
    |> Map.put_new_lazy(:user_email, fn ->
      access_info[:user_email] || System.fetch_env!("GLASSFACTORY_USER_EMAIL")
    end)
    |> Map.put_new_lazy(:api_url, fn ->
      access_info[:api_url] || System.fetch_env!("GLASSFACTORY_API_URL")
    end)
  end
end

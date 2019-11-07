defmodule GlassFactoryApi.Configuration do
  @moduledoc """
  Defines the GlassFactoryApi configuration settings.
  """

  alias GlassFactoryApi.Configuration

  @type t() :: %Configuration{
          subdomain: String.t(),
          user_token: String.t(),
          user_email: String.t(),
          api_url: String.t(),
          adapter: any()
        }

  defstruct [:subdomain, :user_token, :user_email, :api_url, :adapter]

  @access_info Application.get_env(:glass_factory_api, GlassFactoryApi.ApiClient)

  def default_configuration do
    %Configuration{
      subdomain: @access_info[:subdomain],
      user_token: @access_info[:user_token],
      user_email: @access_info[:user_email],
      api_url: @access_info[:api_url],
      adapter: GlassFactoryApi.TeslaAdapter
    }
  end
end

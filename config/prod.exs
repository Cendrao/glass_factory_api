use Mix.Config

config :glass_factory_api, GlassFactoryApi.ApiClient,
  subdomain: System.get_env("GLASSFACTORY_SUBDOMAIN")
  user_token: System.get_env("GLASSFACTORY_USER_TOKEN")
  user_email: System.get_env("GLASSFACTORY_USER_EMAIL")

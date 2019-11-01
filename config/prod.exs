use Mix.Config

config :glass_factory_api, GlassFactoryApi.ApiClient,
  subdomain: System.fetch_env!("GLASSFACTORY_SUBDOMAIN"),
  user_token: System.fetch_env!("GLASSFACTORY_USER_TOKEN"),
  user_email: System.fetch_env!("GLASSFACTORY_USER_EMAIL"),
  api_url: System.fetch_env!("GLASSFACTORY_API_URL")

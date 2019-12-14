# GlassFactoryApi

[![Inline docs](https://inch-ci.org/github/Cendrao/glass_factory_api.svg)](http://inch-ci.org/github/Cendrao/glass_factory_api)

A client for [GlassFactory Public API](https://documenter.getpostman.com/view/4377973/RW8FDkDM?version=latest#intro) written in Elixir.

It is a working in progress so far.

## Installation

To install GlassFactoryApi, add it to your `mix.exs` file:

```elixir
defp deps do
  [
    {:glass_factory_api, "~> 0.1.0"}
  ]
end
```

Then, run `$ mix deps.get`.

## Configuration

In order to consume the Glass Factory API you need the following:

* API URL
* User token
* User email
* Subdomain

These settings can be provided in three different ways.

Straight into the API calls (highest precedence):

```elixir
GlassFactoryApi.Projects.get_project(id, %{
  api_url: "https://my-company.glassfactory.io",
  subdomain: "my-company",
  user_token: "JvBT4XBdoUE2swW3Gfm9",
  user_email: "me@my-company.tld"
})
```

Through your config files:

```elixir
# config/config.exs

config :glass_factory_api, GlassFactoryApi.ApiClient,
  api_url: "https://my-company.glassfactory.io",
  subdomain: "my-company",
  user_token: "JvBT4XBdoUE2swW3Gfm9",
  user_email: "me@my-company.tld"
```

Or with environment variables (lowest precedence):

```bash
export GLASSFACTORY_API_URL="https://my-company.glassfactory.io"
export GLASSFACTORY_SUBDOMAIN="my-company"
export GLASSFACTORY_USER_TOKEN="JvBT4XBdoUE2swW3Gfm9"
export GLASSFACTORY_USER_EMAIL="me@my-company.tld"
```

```elixir
GlassFactoryApi.Projects.get_project(id)
```

## Contributing

WIP

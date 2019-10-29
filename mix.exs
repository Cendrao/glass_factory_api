defmodule GlassFactoryApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :glass_factory_api,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.6"},
      {:jason, "~> 1.1"},
      {:mock, "~> 0.3.0", only: :test},
      {:ex_doc, "~> 0.21.2", only: :dev}
    ]
  end
end

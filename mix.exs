defmodule GlassFactoryApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :glass_factory_api,
      version: "0.1.0",
      elixir: "~> 1.8",
      elixirc_paths: elixirc_paths(Mix.env()),
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
      {:jason, "~> 1.1"},
      {:ex_doc, "~> 0.21.2", only: :dev},
      {:bypass, "~> 1.0", only: :test},
      {:tesla, github: "teamon/tesla"},
      {:mint, "~> 1.0"}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support", "test/fixtures"]
  defp elixirc_paths(_), do: ["lib"]
end

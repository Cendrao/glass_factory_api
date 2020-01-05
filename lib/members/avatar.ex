defmodule GlassFactoryApi.Members.Avatar do
  alias GlassFactoryApi.Configuration

  @type t :: %__MODULE__{
          url: String.t(),
          medium: %{url: String.t()},
          small: %{url: String.t()},
          thumb: %{url: String.t()}
        }

  defstruct [:url, :medium, :small, :thumb]

  @spec to_struct(map(), map()) :: t()
  def to_struct(attrs, config) do
    %__MODULE__{
      url: normalize_image_url(Map.fetch!(attrs, "url"), config),
      medium: %{
        url: normalize_image_url(attrs["medium"]["url"], config)
      },
      small: %{
        url: normalize_image_url(attrs["small"]["url"], config)
      },
      thumb: %{
        url: normalize_image_url(attrs["thumb"]["url"], config)
      }
    }
  end

  defp normalize_image_url(nil, _), do: nil

  defp normalize_image_url(url, configuration) do
    config = Configuration.build(configuration)

    case URI.parse(url) do
      %URI{host: nil, path: path, query: query} ->
        config[:api_url]
        |> URI.parse()
        |> Map.merge(%{path: path, query: query})
        |> URI.to_string()

      _ ->
        url
    end
  end
end

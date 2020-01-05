defmodule GlassFactoryApi.Members.Avatar do
  @type t :: %__MODULE__{
          url: String.t(),
          medium: %{url: String.t()},
          small: %{url: String.t()},
          thumb: %{url: String.t()}
        }

  defstruct [:url, :medium, :small, :thumb]

  @spec to_struct(map()) :: t()
  def to_struct(attrs) do
    %__MODULE__{
      url: Map.fetch!(attrs, "url"),
      medium: %{
        url: attrs["medium"]["url"]
      },
      small: %{
        url: attrs["small"]["url"]
      },
      thumb: %{
        url: attrs["thumb"]["url"]
      }
    }
  end
end

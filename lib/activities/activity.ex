defmodule GlassFactoryApi.Activities.Activity do
  @moduledoc """
  Defines the Activity of an organization.
  """
  alias __MODULE__, as: Activity

  @type t() :: %Activity{
          id: integer(),
          name: String.t()
        }

  defstruct [:id, :name]

  @doc """
  Parse a map into a Activity struct

  ## Examples

      iex> GlassFactoryApi.Activities.Activity.to_struct(%{id: 1234, name: "Integrations"})
      %Activity{
        id: 1234,
        name: "Integrations"
      }
  """
  @spec to_struct(map) :: t
  def to_struct(attrs) do
    %Activity{
      id: Map.fetch!(attrs, "id"),
      name: Map.fetch!(attrs, "name")
    }
  end
end

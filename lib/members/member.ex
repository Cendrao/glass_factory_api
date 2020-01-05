defmodule GlassFactoryApi.Members.Member do
  alias GlassFactoryApi.Members.Avatar

  @moduledoc """
  Defines the Member of organization.
  """

  @type t() :: %__MODULE__{
          name: String.t(),
          email: String.t(),
          id: integer(),
          archived: boolean(),
          capacity: non_neg_integer(),
          freelancer: boolean(),
          joined_at: String.t(),
          avatar: Avatar.t()
        }

  defstruct [:name, :email, :id, :archived, :capacity, :freelancer, :joined_at, :avatar]

  @doc """
  Parse a map into a Member struct

  ## Examples

      iex> GlassFactoryApi.Member.to_struct(%{name: "John Doe", id: 100...})
      %Member{
        name: "John Doe",
        id: 100,
        email: "john.doe@example.org",
        archived: false,
        capacity: 6.0,
        freelancer: false,
        joined_at: "2019-01-01"
      }
  """
  @spec to_struct(map(), map()) :: __MODULE__.t()
  def to_struct(attrs, config) do
    %__MODULE__{
      name: attrs["name"],
      id: attrs["id"],
      email: attrs["email"],
      archived: attrs["archived"],
      capacity: attrs["capacity"],
      freelancer: attrs["freelancer"],
      joined_at: attrs["joined_at"],
      avatar: Avatar.to_struct(attrs["avatar"], config)
    }
  end
end

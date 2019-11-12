defmodule GlassFactoryApi.Clients.Client do
  @moduledoc """
  Defines the Client of organization.
  """
  alias GlassFactoryApi.Clients.Client

  @type t() :: %Client{
          id: integer(),
          name: String.t(),
          archived_at: Date.t(),
          owner_id: integer(),
          office_id: integer()
        }

  defstruct [:id, :name, :archived_at, :owner_id, :office_id]

  @doc """
  Parse a map into a Client struct

  ## Examples

      iex> GlassFactoryApi.Client.to_struct(%{id: 1234, name: "Google"...})
      %Client{
        id: 1234,
        name: "Google",
        archived_at: nil,
        owner_id: 567,
        office_id: 789
      }
  """
  def to_struct(attrs) do
    %Client{
      id: attrs["id"],
      name: attrs["name"],
      archived_at: attrs["archived_at"],
      owner_id: attrs["owner_id"],
      office_id: attrs["office_id"]
    }
  end
end

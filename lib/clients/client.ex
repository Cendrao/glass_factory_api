defmodule GlassFactoryApi.Clients.Client do
  @moduledoc """
  Defines the Client of an organization.
  """
  alias GlassFactoryApi.Clients.Client

  @type t() :: %Client{
          id: String.t(),
          name: String.t(),
          archived_at: String.t() | nil,
          owner_id: String.t(),
          office_id: String.t()
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
  @spec to_struct(map) :: t
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

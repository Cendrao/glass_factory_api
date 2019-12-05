defmodule GlassFactoryApi.Organization.Role do
  @moduledoc """
  Defines a Role of an Organization.
  """

  @type t() :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          description: String.t(),
          department_id: String.t(),
          is_used: boolean,
          rate: String.t(),
          cost: String.t(),
          currency: String.t(),
          archived: boolean
        }

  defstruct [
    :id,
    :name,
    :description,
    :department_id,
    :is_used,
    :rate,
    :cost,
    :currency,
    :archived
  ]

  def to_struct(attrs) do
    %__MODULE__{
      id: Map.fetch!(attrs, "id"),
      name: Map.fetch!(attrs, "name"),
      description: Map.fetch!(attrs, "description"),
      department_id: attrs["department_id"],
      is_used: attrs["is_used"],
      rate: to_string(attrs["rate"]),
      cost: to_string(attrs["cost"]),
      currency: attrs["currency"],
      archived: attrs["archived"]
    }
  end
end

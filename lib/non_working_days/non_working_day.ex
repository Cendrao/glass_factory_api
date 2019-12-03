defmodule GlassFactoryApi.NonWorkingDays.NonWorkingDay do
  @moduledoc """
  Defines a non working day of an office
  """

  alias GlassFactoryApi.NonWorkingDays.NonWorkingDay

  @type t() :: %NonWorkingDay{
          id: String.t(),
          start_date: String.t(),
          end_date: String.t(),
          name: String.t(),
          office_id: String.t()
        }

  defstruct [
    :id,
    :start_date,
    :end_date,
    :name,
    :office_id
  ]

  def to_struct(attrs) do
    %NonWorkingDay{
      id: attrs["id"],
      start_date: attrs["start_date"],
      end_date: attrs["end_date"],
      name: attrs["name"],
      office_id: attrs["office_id"]
    }
  end
end

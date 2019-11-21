defmodule GlassFactoryApi.Vacations.Vacation do
  @moduledoc """
  Defines the Vacations of a member
  """

  alias GlassFactoryApi.Vacations.Vacation

  @type t() :: %Vacation{
          id: String.t(),
          upcoming: boolean(),
          daily_hours: String.t(),
          start_date: String.t(),
          end_date: String.t(),
          days: String.t(),
          vacation_type: String.t(),
          creator_id: String.t(),
          user_id: String.t()
        }

  defstruct [
    :id,
    :upcoming,
    :daily_hours,
    :start_date,
    :end_date,
    :days,
    :vacation_type,
    :creator_id,
    :user_id
  ]

  def to_struct(attrs) do
    %Vacation{
      id: attrs["id"],
      upcoming: attrs["upcoming"],
      daily_hours: attrs["daily_hours"],
      start_date: attrs["start_date"],
      end_date: attrs["end_date"],
      days: attrs["days"],
      vacation_type: attrs["vacation_type"],
      creator_id: attrs["creator_id"],
      user_id: attrs["user_id"]
    }
  end
end

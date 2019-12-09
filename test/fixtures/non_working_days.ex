defmodule GlassFactoryApi.Fixtures.NonWorkingDays do
  def get_all_non_working_days do
    ~s<
    [
      {
        "id": 102,
        "start_date": "2017-07-04",
        "end_date": "2017-07-04",
        "name": "Independence Day",
        "office_id": 101
      },
      {
        "id": 103,
        "start_date": "2017-12-25",
        "end_date": "2017-12-25",
        "name": "Christmas Day",
        "office_id": 101
      }
    ]
    >
  end

  def get_filtered_non_working_days do
    ~s<
    [
      {
        "id": 103,
        "start_date": "2017-12-25",
        "end_date": "2017-12-25",
        "name": "Christmas Day",
        "office_id": 101
      }
    ]
    >
  end
end

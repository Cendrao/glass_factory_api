defmodule GlassFactoryApi.Fixtures.Vacations do
  def get_all_users do
    ~s<
    [
      {
        "id": 119,
        "upcoming": false,
        "daily_hours": 8,
        "start_date": "2017-07-24",
        "end_date": "2017-07-30",
        "days": 7,
        "vacation_type": "paid",
        "creator_id": 722,
        "user_id": 722
      },
      {
        "id": 132,
        "upcoming": false,
        "daily_hours": 8,
        "start_date": "2019-07-20",
        "end_date": "2019-07-30",
        "days": 10,
        "vacation_type": "paid",
        "creator_id": 734,
        "user_id": 734
      }
    ]
    >
  end

  def get_one_user do
    ~s<
    [
      {
        "id": 132,
        "upcoming": false,
        "daily_hours": 8,
        "start_date": "2019-07-20",
        "end_date": "2019-07-30",
        "days": 10,
        "vacation_type": "paid",
        "creator_id": 734,
        "user_id": 734
      }
    ]
    >
  end

end

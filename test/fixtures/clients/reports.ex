defmodule GlassFactoryApi.Fixtures.Clients.Reports do
  def list_time_reports do
    ~s<
    [
      {
        "client_id": 2079,
        "project_id": 14330,
        "job_id": null,
        "activity_id": null,
        "user_id": 3,
        "role_id": 1480,
        "date": "2018-07-10",
        "planned": 8,
        "time": 0
      }
    ]
    >
  end

  def list_rates_and_costs_reports do
    ~s<
    [
      {
        "client_id": 1234,
        "project_id": 12345,
        "job_id": null,
        "activity_id": 123456,
        "user_id": 222,
        "role_id": 1234,
        "date": "2018-06-19",
        "time": 8,
        "rate": 35,
        "cost": 35
      }
    ]
    >
  end
end

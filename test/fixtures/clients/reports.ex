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
end

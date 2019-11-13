defmodule GlassFactoryApi.Fixtures.Projects do
  def list do
    ~s<
    [
      {
        "id": 99999,
        "name": "Big project",
        "archived": false,
        "manager_id": 111222,
        "url": "http://example.org/glassfactory/big-project",
        "office_id": 9999,
        "client_id": 99999,
        "job_id": null,
        "created_at": "2019-08-06 16:08:51",
        "closed_at": "2019-08-14",
        "sequental_id": "0001",
        "billable_status": "non_billable",
        "probability": null,
        "closed": true,
        "probability_state": "closed",
        "enable_general_time": true,
        "pricing": {
          "strategy": "material",
          "rates_type": "custom"
        }
      }
    ]
    >
  end

  def get do
    ~s<
    {
      "id": 99999,
      "name": "Big project",
      "archived": false,
      "manager_id": 111222,
      "url": "http://example.org/glassfactory/big-project",
      "office_id": 9999,
      "client_id": 99999,
      "job_id": null,
      "created_at": "2019-08-06 16:08:51",
      "closed_at": "2019-08-14",
      "sequental_id": "0001",
      "billable_status": "non_billable",
      "probability": null,
      "closed": true,
      "probability_state": "closed",
      "enable_general_time": true,
      "pricing": {
        "strategy": "material",
        "rates_type": "custom"
      }
    }
    >
  end
end

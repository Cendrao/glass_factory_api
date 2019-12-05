defmodule GlassFactoryApi.Fixtures.Roles do
  def list() do
    ~s<
    [
      {
        "id": 3110,
        "name": "partner",
        "description": "Partner",
        "department_id": 10,
        "is_used": true,
        "rate": null,
        "cost": null,
        "currency": null,
        "archived": false
      },
      {
        "id": 3105,
        "name": "assoc",
        "description": "Associate",
        "department_id": 10,
        "is_used": true,
        "rate": null,
        "cost": null,
        "currency": null,
        "archived": false
      }
    ]
    >
  end
end

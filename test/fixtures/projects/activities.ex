defmodule GlassFactoryApi.Fixtures.Projects.Activities do
  def list do
    ~s<
    [
      {
        "id": 1122,
        "name": "General Time"
      },
      {
        "id": 1123,
        "name": "Mobile App"
      },
      {
        "id": 1124,
        "name": "Integrations"
      }
    ]
    >
  end

  def get do
    ~s<
    {
      "id": 1124,
      "name": "Integrations"
    }
    >
  end
end

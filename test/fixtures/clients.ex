defmodule GlassFactoryApi.Fixtures.Clients do
  def get do
    ~s<
    {
      "id": 1234,
      "name": "Google",
      "archived_at": null,
      "owner_id": 567,
      "office_id": 789
    }
    >
  end
end

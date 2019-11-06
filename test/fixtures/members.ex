defmodule GlassFactoryApi.Fixtures.Members do
  def list do
    ~s<
    [
      {
        "id": 2666,
        "name": "John Doe",
        "email": "john.doe@example.org",
        "avatar": {
          "url": "/default_avatar/user/2666.svg",
          "medium": {
            "url": "/default_avatar/user/2666.svg"
          },
          "small": {
            "url": "/default_avatar/user/2666.svg"
          },
          "thumb": {
            "url": "/default_avatar/user/2666.svg"
          }
        },
        "phone": null,
        "skype": null,
        "joined_at": "2019-01-01",
        "freelancer": false,
        "vacation_capacity": null,
        "role_id": 123,
        "capacity": 8.0,
        "archived": false,
        "office_id": 500
      }
    ]
    >
  end

  def get do
    ~s<
    {
      "id": 2666,
      "name": "John Doe",
      "email": "john.doe@example.org",
      "avatar": {
        "url": "/default_avatar/user/2666.svg",
        "medium": {
          "url": "/default_avatar/user/2666.svg"
        },
        "small": {
          "url": "/default_avatar/user/2666.svg"
        },
        "thumb": {
          "url": "/default_avatar/user/2666.svg"
        }
      },
      "phone": null,
      "skype": null,
      "joined_at": "2019-01-01",
      "freelancer": false,
      "vacation_capacity": null,
      "role_id": 123,
      "capacity": 8.0,
      "archived": false,
      "office_id": 500
    }
    >
  end
end

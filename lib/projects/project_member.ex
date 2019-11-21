defmodule GlassFactoryApi.Projects.ProjectMember do
  @moduledoc """
  Defines a Member of a Project.
  """

  @type t() :: %__MODULE__{
          id: String.t(),
          user_id: String.t(),
          project_id: String.t()
        }

  defstruct [
    :id,
    :user_id,
    :project_id
  ]

  @doc """
  Parser a map into a ProjectMember struct.

  ## Examples

      iex> GlassFactoryApi.Projects.ProjectMember.to_struct(%{"id" => 1, "user_id" => 123, "project_id" => 456})
      %ProjectMember{
        id: "1",
        user_id: "123",
        project_id: "456"
      }
  """
  @spec to_struct(map()) :: __MODULE__.t()
  def to_struct(attrs) do
    %__MODULE__{
      id: attrs["id"],
      user_id: attrs["user_id"],
      project_id: attrs["project_id"]
    }
  end
end

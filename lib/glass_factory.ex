defmodule GlassFactoryApi.GlassFactory do
  alias GlassFactoryApi.{Clients, Members, Projects, Vacations}
  alias GlassFactoryApi.Clients.Reports

  # Clients
  defdelegate get_client(client_id, config \\ %{}), to: Clients
  defdelegate get_client!(client_id, config \\ %{}), to: Clients
  defdelegate list_clients(config \\ %{}), to: Clients
  defdelegate list_clients!(config \\ %{}), to: Clients

  # Members
  defdelegate get_member(member_id, config \\ %{}), to: Members
  defdelegate get_member!(member_id, config \\ %{}), to: Members
  defdelegate list_members(config \\ %{}), to: Members
  defdelegate list_members!(config \\ %{}), to: Members

  # Projects
  defdelegate get_project(project_id, config \\ %{}), to: Projects
  defdelegate get_project!(project_id, config \\ %{}), to: Projects
  defdelegate list_projects(config \\ %{}), to: Projects
  defdelegate list_projects!(config \\ %{}), to: Projects
  defdelegate list_project_members(project_id, config \\ %{}), to: Projects, as: :list_members
  defdelegate list_project_members!(project_id, config \\ %{}), to: Projects, as: :list_members!

  # Vacations
  defdelegate get_vacations(filters \\ [], config \\ %{}), to: Vacations
  defdelegate get_vacations!(filters \\ [], config \\ %{}), to: Vacations

  # Clients Reports
  defdelegate list_time_reports(client_id, opts \\ [], config \\ %{}), to: Reports
  defdelegate list_time_reports!(client_id, opts \\ [], config \\ %{}), to: Reports
  defdelegate list_rates_and_costs_reports(client_id, opts \\ [], config \\ %{}), to: Reports
  defdelegate list_rates_and_costs_reports!(client_id, opts \\ [], config \\ %{}), to: Reports
end

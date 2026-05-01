defmodule PhoenixStarter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixStarterWeb.Telemetry,
      PhoenixStarter.Repo,
      {DNSCluster, query: Application.get_env(:phoenix_starter, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixStarter.PubSub},
      {Finch, name: PhoenixStarter.Finch},
      PhoenixStarterWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixStarter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixStarterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

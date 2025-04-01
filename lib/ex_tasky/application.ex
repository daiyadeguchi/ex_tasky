defmodule ExTasky.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ExTaskyWeb.Telemetry,
      ExTasky.Repo,
      {DNSCluster, query: Application.get_env(:ex_tasky, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ExTasky.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ExTasky.Finch},
      # Start a worker by calling: ExTasky.Worker.start_link(arg)
      # {ExTasky.Worker, arg},
      # Start to serve requests, typically the last entry
      ExTaskyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExTasky.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExTaskyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

defmodule KubeDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = [
      k8s: [
        strategy: Cluster.Strategy.Kubernetes.DNS,
        config: [
          service: "kube-demo-static-service-name",
          application_name: "kube_demo"
        ]
      ]
    ]

    children = [
      KubeDemoWeb.Telemetry,
      {Phoenix.PubSub, name: KubeDemo.PubSub},
      KubeDemoWeb.Endpoint,
      {Cluster.Supervisor, [topologies, [name: KubeDemo.ClusterSupervisor]]}
    ]

    opts = [strategy: :one_for_one, name: KubeDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KubeDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

defmodule KubeDemoWeb.HealthCheckController do
  use KubeDemoWeb, :controller

  def health_check(conn, _params) do
    nodes = Node.list() ++ [node()]

    json(conn, %{
      status: "healthy",
      nodes: Enum.map(nodes, &Atom.to_string/1)
    })
  end
end

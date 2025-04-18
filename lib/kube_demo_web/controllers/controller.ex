defmodule KubeDemoWeb.Controller do
  use KubeDemoWeb, :controller

  def index(conn, _params) do
    current_node = node() |> Atom.to_string()

    json(conn, %{
      message: "Hello from #{current_node}"
    })
  end
end

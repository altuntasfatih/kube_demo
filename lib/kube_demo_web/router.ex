defmodule KubeDemoWeb.Router do
  use KubeDemoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KubeDemoWeb do
    pipe_through :api

    get "/", Controller, :index
    get "/health_check", HealthCheckController, :health_check
  end
end

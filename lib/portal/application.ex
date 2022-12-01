defmodule Portal.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Portal.Worker.start_link(arg)
      # {Portal.Worker, arg}
      # Strategy sets how the supervisor reacts in case the process crashes
      # Name is a reference to the process we can call from anywhere
      {DynamicSupervisor, strategy: :one_for_one, name: Portal.DoorSupervisor}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Portal.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

# Supervisor --> Processes known before hand
# DynamicSupervisor --> Processes that are started dynamically

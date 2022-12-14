defmodule Urlrog.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      UrlrogWeb.Telemetry,
      # Start the URL lookup thread
      Application.get_env(:urlrog, :image_processor),
      # Urlrog.Lookup,
      # Start the PubSub system
      {Phoenix.PubSub, name: Urlrog.PubSub},
      # Start the Endpoint (http/https)
      UrlrogWeb.Endpoint
      # Start a worker by calling: Urlrog.Worker.start_link(arg)
      # {Urlrog.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Urlrog.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UrlrogWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

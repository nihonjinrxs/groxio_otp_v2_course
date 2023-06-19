defmodule Brother.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Brother.Worker.start_link(arg)
      # {Brother.Worker, arg}
      Brother, # using Brother's child_spec with default args of []
      {Brother, {:winston, "It's not true, so it can't be."}}, # using Brother's child_spec function passing args
      %{
        id: :parsons,
        start: {Brother, :start_link, [parsons: "Workin' hard, workin' hard"]},
      }, # manually created child spec
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Brother.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule Brother.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Registry!
      {Registry, keys: :unique, name: Brother.Registry},

      # Just create a dynamic supervisor to handle starting processes on demand
      {DynamicSupervisor, name: Brother.DynamicSupervisor},

      # using Brother's child_spec with default args of []:
      # Brother,
      # {Brother, []},
      # using Brother's child_spec function passing args
      # {Brother, {:winston, "It's not true, so it can't be."}},
      # manually created child spec
      # %{
      #   id: :parsons,
      #   start: {Brother, :start_link, [parsons: "Workin' hard, workin' hard"]},
      # },

      # Consistent syntax
      {Brother, {:julia, "Coffee... that's the stuff!"}},
      {Brother, {:parsons, "Workin' hard, workin' hard"}},
      {Brother, {:winston, "It's not true, so it can't be."}},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: Brother.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

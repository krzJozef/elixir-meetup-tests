defmodule Bookshelf.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Bookshelf.Repo
    ]

    opts = [strategy: :one_for_one, name: Bookshelf.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

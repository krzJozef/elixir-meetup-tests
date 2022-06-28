defmodule Bookshelf.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Bookshelf.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Bookshelf.DataCase
    end
  end

  setup tags do
    setup_sandbox(tags)

    :ok
  end

  def setup_sandbox(_tags) do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Bookshelf.Repo)
  end
end

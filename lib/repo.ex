defmodule Bookshelf.Repo do
  use Ecto.Repo,
    otp_app: :bookshelf,
    adapter: Ecto.Adapters.Postgres
end

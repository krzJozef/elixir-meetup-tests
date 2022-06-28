import Config

config :bookshelf, ecto_repos: [Bookshelf.Repo]

config :bookshelf, book_repo: Bookshelf.Infrastructure.EctoBookRepo
config :bookshelf, author_repo: Bookshelf.Infrastructure.EctoAuthorRepo

config :bookshelf, Bookshelf.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "bookshelf",
  port: "5432"

import_config "#{config_env()}.exs"

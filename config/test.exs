import Config

# config :bookshelf, book_repo: Bookshelf.Model.BookRepoMock
# config :bookshelf, author_repo: Bookshelf.Model.AuthorRepoMock
config :bookshelf, event_bus: Bookshelf.Model.EventBusMock

config :bookshelf, Bookshelf.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "bookshelf_test",
  pool: Ecto.Adapters.SQL.Sandbox,
  port: "5432"

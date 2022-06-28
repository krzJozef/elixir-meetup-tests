defmodule Bookshelf.Infrastructure.EctoBook do
  use Ecto.Schema

  import Ecto.Changeset

  alias Bookshelf.Model.Book

  @primary_key {:id, :binary_id, autogenerate: false}

  schema "books" do
    field(:title, :string)
    field(:isbn, :string)
    field(:author_id, :string)
    field(:rating, :integer)

    timestamps()
  end

  @fields ~w(id title isbn author_id rating)a

  def changeset(%__MODULE__{} = ecto_book, %Book{} = book) do
    params = Map.from_struct(book)

    ecto_book
    |> cast(params, @fields)
  end
end

defmodule Bookshelf.Infrastructure.EctoBookRepo do
  @behaviour Bookshelf.Model.BookRepo

  alias Bookshelf.Infrastructure.EctoBook
  alias Bookshelf.Model.Book
  alias Bookshelf.Repo

  def save(book) do
    {:ok, ecto_book} =
      EctoBook
      |> Repo.get(book.id)
      |> case do
        nil -> %EctoBook{}
        ecto_book -> ecto_book
      end
      |> EctoBook.changeset(book)
      |> Repo.insert_or_update()

    {:ok, Book.new(ecto_book)}
  end

  def by_id(id) do
    EctoBook
    |> Repo.get(id)
    |> Book.new()
  end
end

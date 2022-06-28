defmodule Bookshelf.Infrastructure.EctoAuthor do
  use Ecto.Schema

  import Ecto.Changeset

  alias Bookshelf.Model.Author

  @primary_key {:id, :binary_id, autogenerate: false}

  schema "authors" do
    field(:name, :string)
    field(:stars, :integer)

    timestamps()
  end

  @fields ~w(id name stars)a

  def changeset(%__MODULE__{} = ecto_author, %Author{} = author) do
    params = Map.from_struct(author)

    ecto_author
    |> cast(params, @fields)
  end
end

defmodule Bookshelf.Infrastructure.EctoAuthorRepo do
  @behaviour Bookshelf.Model.AuthorRepo

  alias Bookshelf.Infrastructure.EctoAuthor
  alias Bookshelf.Repo
  alias Bookshelf.Model.Author

  def save(author) do
    {:ok, ecto_author} =
      EctoAuthor
      |> Repo.get(author.id)
      |> case do
        nil -> %EctoAuthor{}
        ecto_author -> ecto_author
      end
      |> EctoAuthor.changeset(author)
      |> Repo.insert_or_update()

    {:ok, Author.new(ecto_author)}
  end

  def by_id(id) do
    EctoAuthor
    |> Repo.get(id)
    |> Author.new()
  end
end

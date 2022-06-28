defmodule Bookshelf.Test.AuthorFixture do
  alias Bookshelf.Model.Author
  alias Bookshelf.Infrastructure.EctoAuthorRepo

  def insert!(attrs \\ []) do
    {:ok, author} =
      attrs
      |> build()
      |> EctoAuthorRepo.save()

    author
  end

  def build(attrs \\ []) do
    Author.new(%{
      id: attrs[:id] || UUID.uuid4(),
      name: attrs[:name] || "Name",
      stars: attrs[:stars] || 0
    })
  end
end

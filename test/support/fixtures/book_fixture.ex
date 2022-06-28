defmodule Bookshelf.Test.BookFixture do
  alias Bookshelf.Model.Book
  alias Bookshelf.Infrastructure.EctoBookRepo

  def insert!(attrs \\ []) do
    {:ok, book} =
      attrs
      |> build()
      |> EctoBookRepo.save()

    book
  end

  def build(attrs \\ []) do
    Book.new(%{
      id: attrs[:id] || UUID.uuid4(),
      title: attrs[:title] || "Title",
      isbn: attrs[:isbn] || "somecode",
      author_id: attrs[:author_id] || UUID.uuid4(),
      rating: attrs[:rating] || 0
    })
  end
end

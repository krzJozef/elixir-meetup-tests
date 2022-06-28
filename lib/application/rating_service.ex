defmodule Bookshelf.Application.RatingService do
  alias Bookshelf.Model.Book
  alias Bookshelf.Model.Author
  alias Bookshelf.Model.Ratings

  def rate_book(book_id, rating) do
    with %Book{author_id: author_id} = book <- book_repo().by_id(book_id),
         %Author{} = author <- author_repo().by_id(author_id) do
      %{book: book, author: author} = Ratings.rate(%{book: book, author: author, rating: rating})

      {:ok, _author} = author_repo().save(author)
      {:ok, book} = book_repo().save(book)

      event_bus().publish("book_rated")

      {:ok, book}
    end
  end

  defp book_repo do
    Application.get_env(:bookshelf, :book_repo)
  end

  defp author_repo do
    Application.get_env(:bookshelf, :author_repo)
  end

  defp event_bus() do
    Application.get_env(:bookshelf, :event_bus)
  end
end

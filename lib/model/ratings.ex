defmodule Bookshelf.Model.Ratings do
  alias Bookshelf.Model.Book
  alias Bookshelf.Model.Author

  def rate(%{book: book, author: author, rating: rating}) do
    rated_book = Book.rate(book, rating)

    author = if rating <= 5, do: Author.remove_star(author), else: Author.add_star(author)

    %{
      book: rated_book,
      author: author
    }
  end
end

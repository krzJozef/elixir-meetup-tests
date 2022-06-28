defmodule Bookshelf.Model.BookRepo do
  alias Bookshelf.Model.Book

  @callback by_id(book_id :: Book.id()) :: Book.t()
  @callback save(book :: Book.t()) :: {:ok, Book.t()}
end

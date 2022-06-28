defmodule Bookshelf.Model.BookTest do
  use ExUnit.Case, async: true

  alias Bookshelf.Model.Book
  alias Bookshelf.Test.BookFixture

  describe "rate/2" do
    test "adds rating to the book" do
      book = BookFixture.build()

      assert %Book{
               id: book.id,
               author_id: book.author_id,
               title: book.title,
               isbn: book.isbn,
               rating: 5
             } == Book.rate(book, 5)
    end

    test "does not allow rating below 0" do
      book = BookFixture.build()

      assert %Book{
               id: book.id,
               author_id: book.author_id,
               title: book.title,
               isbn: book.isbn,
               rating: 0
             } == Book.rate(book, -1)
    end

    test "does not allow rating over 10" do
      book = BookFixture.build()

      assert %Book{
               id: book.id,
               author_id: book.author_id,
               title: book.title,
               isbn: book.isbn,
               rating: 10
             } == Book.rate(book, 11)
    end
  end
end

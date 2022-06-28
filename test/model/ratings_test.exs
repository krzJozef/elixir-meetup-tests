defmodule Bookshelf.Model.RatingsTest do
  use ExUnit.Case, async: true

  alias Bookshelf.Model.Ratings
  alias Bookshelf.Model.Author
  alias Bookshelf.Model.Book

  alias Bookshelf.Test.AuthorFixture
  alias Bookshelf.Test.BookFixture

  describe "rate/1" do
    test "adds rating to the book" do
      author = AuthorFixture.build()
      book = BookFixture.build()
      rating = 6

      %{author: _author, book: book} = Ratings.rate(%{book: book, author: author, rating: rating})

      assert %Book{
               id: book.id,
               author_id: book.author_id,
               rating: rating,
               title: book.title,
               isbn: book.isbn
             } == book
    end

    test "when rating lower than or equal 5, removes star from author" do
      author = AuthorFixture.build(stars: 2)
      book = BookFixture.build()
      rating = 5

      %{author: author, book: _book} = Ratings.rate(%{book: book, author: author, rating: rating})

      assert %Author{
               id: author.id,
               name: author.name,
               stars: 1
             } == author
    end

    test "when rating bigger than 5, adds star to an author" do
      author = AuthorFixture.build(stars: 2)
      book = BookFixture.build()
      rating = 6

      %{author: author, book: _book} = Ratings.rate(%{book: book, author: author, rating: rating})

      assert %Author{
               id: author.id,
               name: author.name,
               stars: 3
             } == author
    end
  end
end

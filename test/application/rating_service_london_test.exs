defmodule Bookshelf.Application.RatingServiceLondonTest do
  use ExUnit.Case, async: true

  import Hammox

  alias Bookshelf.Application.RatingService
  alias Bookshelf.Model.Book
  alias Bookshelf.Model.Author

  alias Bookshelf.Test.AuthorFixture
  alias Bookshelf.Test.BookFixture

  alias Bookshelf.Model.BookRepoMock, as: BookRepo
  alias Bookshelf.Model.AuthorRepoMock, as: AuthorRepo
  alias Bookshelf.Model.EventBusMock, as: EventBus

  @moduletag :skip

  setup :verify_on_exit!

  describe "rate_book/2" do
    test "returns updated entities" do
      author = AuthorFixture.build()
      author_id = author.id
      book = BookFixture.build(author_id: author_id)
      book_id = book.id
      rating = 6

      stub(BookRepo, :by_id, fn ^book_id ->
        book
      end)

      stub(AuthorRepo, :by_id, fn ^author_id ->
        author
      end)

      stub(AuthorRepo, :save, fn author -> {:ok, author} end)
      stub(BookRepo, :save, fn book -> {:ok, book} end)
      stub(EventBus, :publish, fn "book_rated" -> :ok end)

      assert {:ok,
              %Book{
                id: book.id,
                title: book.title,
                isbn: book.isbn,
                author_id: book.author_id,
                rating: rating
              }} == RatingService.rate_book(book.id, rating)
    end

    test "saves entities to the database" do
      %{
        id: author_id,
        name: author_name
      } = author = AuthorFixture.build()

      %{
        id: book_id,
        title: book_title,
        isbn: book_isbn,
        author_id: book_author_id
      } = book = BookFixture.build(author_id: author_id)

      rating = 6

      stub(BookRepo, :by_id, fn ^book_id ->
        book
      end)

      stub(AuthorRepo, :by_id, fn ^author_id ->
        author
      end)

      stub(EventBus, :publish, fn "book_rated" -> :ok end)

      expect(BookRepo, :save, fn %Book{
                                   id: ^book_id,
                                   title: ^book_title,
                                   isbn: ^book_isbn,
                                   author_id: ^book_author_id,
                                   rating: ^rating
                                 } = book ->
        {:ok, book}
      end)

      expect(AuthorRepo, :save, fn %Author{
                                     id: ^author_id,
                                     name: ^author_name,
                                     stars: 1
                                   } = author ->
        {:ok, author}
      end)

      RatingService.rate_book(book_id, rating)
    end

    test "publishes event to the event bus" do
      author = AuthorFixture.build()

      book = BookFixture.build(author_id: author.id)

      rating = 6

      stub(BookRepo, :by_id, fn _book_id ->
        book
      end)

      stub(AuthorRepo, :by_id, fn _author_id ->
        author
      end)

      stub(BookRepo, :save, fn book ->
        {:ok, book}
      end)

      stub(AuthorRepo, :save, fn author ->
        {:ok, author}
      end)

      expect(EventBus, :publish, fn "book_rated" -> :ok end)

      RatingService.rate_book(book.id, rating)
    end
  end
end

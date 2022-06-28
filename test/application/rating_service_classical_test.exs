defmodule Bookshelf.Application.RatingServiceClassicalTest do
  use Bookshelf.DataCase, async: true

  import Hammox

  alias Bookshelf.Application.RatingService
  alias Bookshelf.Model.Book
  alias Bookshelf.Model.Author

  alias Bookshelf.Test.AuthorFixture
  alias Bookshelf.Test.BookFixture

  alias Bookshelf.Infrastructure.EctoAuthorRepo
  alias Bookshelf.Infrastructure.EctoBookRepo

  alias Bookshelf.Model.EventBusMock, as: EventBus

  # @moduletag :skip

  setup :verify_on_exit!

  describe "rate_book/2" do
    test "returns updated entities" do
      author = AuthorFixture.insert!()
      book = BookFixture.insert!(author_id: author.id)
      rating = 6

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
      author = AuthorFixture.insert!()

      book = BookFixture.insert!(author_id: author.id)

      rating = 6

      stub(EventBus, :publish, fn "book_rated" -> :ok end)

      RatingService.rate_book(book.id, rating)

      assert %Book{
               id: book.id,
               title: book.title,
               isbn: book.isbn,
               author_id: book.author_id,
               rating: rating
             } == EctoBookRepo.by_id(book.id)

      assert %Author{
               id: author.id,
               name: author.name,
               stars: 1
             } == EctoAuthorRepo.by_id(author.id)
    end

    test "publishes event to the event bus" do
      author = AuthorFixture.insert!()
      book = BookFixture.insert!(author_id: author.id)
      rating = 6

      expect(EventBus, :publish, fn "book_rated" -> :ok end)

      RatingService.rate_book(book.id, rating)
    end
  end
end

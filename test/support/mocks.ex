defmodule Bookshelf.Mocks do
  import Hammox

  defmock(Bookshelf.Model.AuthorRepoMock, for: Bookshelf.Model.AuthorRepo)
  defmock(Bookshelf.Model.BookRepoMock, for: Bookshelf.Model.BookRepo)
  defmock(Bookshelf.Model.EventBusMock, for: Bookshelf.Model.EventBus)
end

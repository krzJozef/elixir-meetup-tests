defmodule Bookshelf.Model.AuthorRepo do
  alias Bookshelf.Model.Author

  @callback by_id(author_id :: Author.id()) :: Author.t()
  @callback save(author :: Author.t()) :: {:ok, Author.t()}
end

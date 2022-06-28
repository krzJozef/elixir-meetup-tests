defmodule Bookshelf.Model.Book do
  alias Bookshelf.Model.Author

  @type id :: String.t() | nil
  @type title :: String.t()
  @type isbn :: String.t()
  @type rating :: integer() | nil

  @type t :: %__MODULE__{
          id: id(),
          title: title(),
          isbn: isbn(),
          author_id: Author.id(),
          rating: rating()
        }

  @min_rating 0
  @max_rating 10

  defstruct ~w(id title isbn author_id rating)a

  def new(%{title: title, isbn: isbn, author_id: author_id} = attrs) do
    %__MODULE__{
      id: attrs.id,
      title: title,
      isbn: isbn,
      author_id: author_id,
      rating: attrs.rating
    }
  end

  def rate(%__MODULE__{} = book, rating) when rating < @min_rating, do: rate(book, @min_rating)
  def rate(%__MODULE__{} = book, rating) when rating > @max_rating, do: rate(book, @max_rating)

  def rate(%__MODULE__{} = book, rating) do
    Map.put(book, :rating, rating)
  end
end

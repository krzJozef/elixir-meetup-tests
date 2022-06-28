defmodule Bookshelf.Model.Author1 do
  @type id :: String.t()
  @type name :: String.t()
  @type stars :: integer()

  @type t :: %__MODULE__{
          id: id(),
          name: name(),
          stars: stars(),
        }

  defstruct ~w(id name stars)a

  @max_stars 5
  @min_stars 0

  def new(attrs) do
    %__MODULE__{
      id: attrs.id,
      name: attrs.name,
      stars: attrs.stars || 0
    }
  end

  def add_star(%__MODULE__{stars: current_stars} = author) when current_stars == @max_stars,
    do: author

  def add_star(%__MODULE__{stars: current_stars} = author),
    do: %{author | stars: current_stars + 1}

  def remove_star(%__MODULE__{stars: current_stars} = author) when current_stars == @min_stars,
    do: author

  def remove_star(%__MODULE__{stars: current_stars} = author),
    do: %{author | stars: current_stars - 1}
end

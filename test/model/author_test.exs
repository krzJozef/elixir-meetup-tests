defmodule Bookshelf.Model.AuthorTest do
  use ExUnit.Case, async: true
  alias Bookshelf.Model.Author
  alias Bookshelf.Test.AuthorFixture

  describe "add_star/1" do
    test "adds star to the author" do
      author = AuthorFixture.build(stars: 2)

      assert %Author{
               id: author.id,
               name: author.name,
               stars: 3
             } == Author.add_star(author)
    end

    test "when author already has maximum number of stars, doesn't do anything" do
      author = AuthorFixture.build(stars: 5)

      assert %Author{
               id: author.id,
               name: author.name,
               stars: 5
             } == Author.add_star(author)
    end
  end

  describe "remove_star/1" do
    test "removes star from the author" do
      author = AuthorFixture.build(stars: 2)

      assert %Author{
               id: author.id,
               name: author.name,
               stars: 1
             } == Author.remove_star(author)
    end

    test "when author already has minimum number of stars, doesn't do anything" do
      author = AuthorFixture.build(stars: 0)

      assert %Author{
               id: author.id,
               name: author.name,
               stars: 0
             } == Author.remove_star(author)
    end
  end
end

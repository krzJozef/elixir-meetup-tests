defmodule Bookshelf.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table("books", primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :isbn, :string
      add :author_id, :string
      add :rating, :integer

      timestamps()
    end

    create table("authors", primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :name, :string
      add :stars, :integer

      timestamps()
    end
  end
end

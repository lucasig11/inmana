defmodule Inmana.Repo.Migrations.CreatePasswordColumn do
  use Ecto.Migration

  def change do
    alter table("restaurants") do
      add :password, :string
    end
  end
end

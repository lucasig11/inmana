defmodule Inmana.Repo.Migrations.CreateRestaurantsTable do
  use Ecto.Migration

  # the config for using uuid's is at config/config.exs
  def change do
    create table(:restaurants) do
      add :email, :string
      add :name, :string

      timestamps() # automatically inserts the columns 'InsertedAt' and 'UpdatedAt'
    end


    create unique_index(:restaurants, [:email]) # dont register 2 rest. w/ the same e-mail
  end
end

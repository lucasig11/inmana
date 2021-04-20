# This is the schema (model)
defmodule Inmana.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  # Set our schema primary key to be and autogen. uuid
  @primary_key {:id, :binary_id, autogenerate: true}

  # Map migration fields
  schema "restaurants" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  # Acts like a middleware that casts/validates data that goes into the database
  # changeset |> Repo.insert()
  def changeset(params) do
    # __MODULE__ is replaced by the module's name
    %__MODULE__{}
    |> cast(params, [:email, :name])
    |> validate_required([:email, :name])
    |> validate_length(:name, min: 2)
    # "regex" to validate the email
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
  end
end

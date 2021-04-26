# This is the schema (model)
defmodule Inmana.Supply do
  use Ecto.Schema
  import Ecto.Changeset

  alias Inmana.Restaurant

  # Set our schema primary key to be and autogen. uuid
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:description, :expiration_date, :responsible, :restaurant_id]

  @derive {Jason.Encoder, only: @required_params ++ [:id, :updated_at]}

  # Map migration fields
  schema "supplies" do
    field :description, :string
    field :responsible, :string
    field :expiration_date, :date

    belongs_to :restaurant, Restaurant

    timestamps()
  end

  # Acts like a middleware that casts/validates data that goes into the database
  # changeset |> Repo.insert()
  def changeset(params) do
    # __MODULE__ is replaced by the module's name
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:description, min: 3)
    |> validate_length(:responsible, min: 3)
  end
end

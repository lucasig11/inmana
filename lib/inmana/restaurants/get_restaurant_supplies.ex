defmodule Inmana.Restaurants.GetSupplies do
  import Ecto.Query
  alias Inmana.{Repo, Supply}

  def call(uuid) do
    query =
      from s in Supply,
        where: s.restaurant_id == ^uuid

    query
    |> Repo.all()
  end
end

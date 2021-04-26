defmodule Inmana.Supplies.List do
  import Ecto.Query
  alias Inmana.{Repo, Supply}

  def call(uuid) do
    query =
      from s in Supply,
        where: s.restaurant_id == ^uuid

    query
    |> Repo.all()
    |> Enum.sort_by(fn %Supply{expiration_date: date} -> date end)
  end
end

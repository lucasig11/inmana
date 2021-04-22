defmodule Inmana.Supplies.GetByExpiration do
  import Ecto.Query

  alias Inmana.{Restaurant, Supply, Repo}

  def call do
    today = Date.utc_today()
    bow = Date.beginning_of_week(today)
    eow = Date.end_of_week(today)

    query =
      from supply in Supply,
        where: supply.expiration_date >= ^bow and supply.expiration_date <= ^eow

    query
    |> Repo.all()
    |> Enum.group_by(fn %Supply{restaurant: %Restaurant{email: email}} -> email end)
  end
end

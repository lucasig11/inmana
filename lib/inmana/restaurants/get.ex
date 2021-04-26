defmodule Inmana.Restaurants.Get do
  import Ecto.Query
  alias Inmana.{Repo, Restaurant}

  def call() do
    query =
      from r in Restaurant,
        select: %{:name => r.name, :email => r.email, :id => r.id}

    query
    |> Repo.all()
  end
end

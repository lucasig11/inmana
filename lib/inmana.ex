defmodule Inmana do
  alias Inmana.Supplies.Create, as: CreateSupply
  alias Inmana.Restaurants.Create, as: CreateRestaurant

  defdelegate create_restaurant(params), to: CreateRestaurant, as: :call
  defdelegate create_supply(params), to: CreateSupply, as: :call
end

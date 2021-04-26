defmodule Inmana do
  alias Inmana.Restaurants.Create, as: CreateRestaurant
  alias Inmana.Restaurants.List, as: ListRestaurants

  alias Inmana.Supplies.Create, as: CreateSupply
  alias Inmana.Supplies.Get, as: ShowSupply
  alias Inmana.Supplies.List, as: ListSupplies

  defdelegate create_restaurant(params), to: CreateRestaurant, as: :call
  defdelegate list_restaurants(), to: ListRestaurants, as: :call

  defdelegate create_supply(params), to: CreateSupply, as: :call
  defdelegate get_supply(params), to: ShowSupply, as: :call
  defdelegate list_supplies(params), to: ListSupplies, as: :call
end

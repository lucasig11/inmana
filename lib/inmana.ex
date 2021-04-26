defmodule Inmana do
  alias Inmana.Restaurants.Create, as: CreateRestaurant
  alias Inmana.Restaurants.Get, as: GetRestaurants

  alias Inmana.Supplies.Create, as: CreateSupply
  alias Inmana.Supplies.Get, as: ShowSupply

  defdelegate create_restaurant(params), to: CreateRestaurant, as: :call
  defdelegate list_restaurants(), to: GetRestaurants, as: :call

  defdelegate create_supply(params), to: CreateSupply, as: :call
  defdelegate get_supply(params), to: ShowSupply, as: :call
end

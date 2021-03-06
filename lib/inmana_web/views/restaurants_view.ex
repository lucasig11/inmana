defmodule InmanaWeb.RestaurantsView do
  use InmanaWeb, :view

  def render("create.json", %{restaurant: restaurant}) do
    %{
      message: "Restaurant succesfully registered!",
      restaurant: restaurant
    }
  end

  def render("index.json", %{restaurants: restaurants}) do
    %{restaurants: restaurants}
  end
end

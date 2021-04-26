defmodule InmanaWeb.RestaurantsViewTest do
  use InmanaWeb.ConnCase

  import Phoenix.View

  alias Inmana.Restaurant
  alias InmanaWeb.RestaurantsView

  describe "render/2" do
    test "renders create.json" do
      params = %{name: "TestRestaurant", email: "test@rest.com", password: "testpass"}
      {:ok, restaurant} = Inmana.create_restaurant(params)

      response = render(RestaurantsView, "create.json", restaurant: restaurant)

      assert %{
               message: "Restaurant succesfully registered!",
               restaurant: %Restaurant{
                 email: "test@rest.com",
                 id: _,
                 name: "TestRestaurant",
                 password: _
               }
             } = response
    end
  end
end

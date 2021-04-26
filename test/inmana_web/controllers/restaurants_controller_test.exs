defmodule InmanaWeb.RestaurantsControllerTest do
  use InmanaWeb.ConnCase

  describe "create/2" do
    test "should create the user with valid inputs", %{conn: conn} do
      params = %{name: "TestRestaurant", email: "test@rest.com", password: "testpassword"}

      response =
        conn
        |> post(Routes.restaurants_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "Restaurant succesfully registered!",
               "restaurant" => %{
                 "email" => "test@rest.com",
                 "id" => _id,
                 "name" => "TestRestaurant"
               }
             } = response
    end

    test "should throw an error on invalid inputs", %{conn: conn} do
      params = %{name: "TestRestaurant"}

      response =
        conn
        |> post(Routes.restaurants_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{"message" => %{"email" => ["can't be blank"]}} = response
    end
  end
end

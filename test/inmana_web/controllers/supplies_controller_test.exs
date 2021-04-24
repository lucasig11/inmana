defmodule InmanaWeb.SuppliesControllerTest do
  use InmanaWeb.ConnCase, async: true

  defp mock_restaurant(conn) do
    params = %{name: "TestRestaurant", email: "test@rest.com"}

    conn
    |> post(Routes.restaurants_path(conn, :create, params))
    |> json_response(:created)
    |> Map.get("restaurant")
    |> Map.get("id")
  end

  describe "create/2" do
    test "should create the supply on valid inputs", %{conn: conn} do
      params = %{
        description: "TestSupply",
        responsible: "TestResponsible",
        expiration_date: "2021-05-10",
        restaurant_id: mock_restaurant(conn)
      }

      response =
        conn
        |> post(Routes.supplies_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "Supply succesfully registered!",
               "supply" => %{
                 "description" => "TestSupply",
                 "expiration_date" => "2021-05-10",
                 "id" => _sid,
                 "responsible" => "TestResponsible",
                 "restaurant_id" => _rid
               }
             } = response
    end

    test "should return an error on invalid description", %{conn: conn} do
      params = %{
        description: "T",
        responsible: "TestResponsible",
        expiration_date: "2021-05-10",
        restaurant_id: mock_restaurant(conn)
      }

      response =
        conn
        |> post(Routes.supplies_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{
               "message" => %{
                 "description" => ["should be at least 3 character(s)"]
               }
             } = response
    end

    test "should return an error on invalid responsible", %{conn: conn} do
      params = %{
        description: "TestSupply",
        responsible: "T",
        expiration_date: "2021-05-10",
        restaurant_id: mock_restaurant(conn)
      }

      response =
        conn
        |> post(Routes.supplies_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{
               "message" => %{
                 "responsible" => ["should be at least 3 character(s)"]
               }
             } = response
    end

    test "should return an error on invalid date", %{conn: conn} do
      params = %{
        description: "TestSupply",
        responsible: "TestResponsible",
        restaurant_id: mock_restaurant(conn)
      }

      response =
        conn
        |> post(Routes.supplies_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{"message" => %{"expiration_date" => ["can't be blank"]}} = response
    end

    test "should return an error on invalid restaurant_id", %{conn: conn} do
      params = %{
        description: "TestSupply",
        responsible: "TestResponsible",
        expiration_date: "2021-05-10"
      }

      response =
        conn
        |> post(Routes.supplies_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{"message" => %{"restaurant_id" => ["can't be blank"]}} = response
    end
  end

  describe "show/2" do
    test "should return the supply data", %{conn: conn} do
      # Create supply
      %{"supply" => %{"id" => uuid}} =
        conn
        |> post(
          Routes.supplies_path(conn, :create, %{
            description: "TestSupply",
            responsible: "TestResponsible",
            expiration_date: "2021-05-10",
            restaurant_id: mock_restaurant(conn)
          })
        )
        |> json_response(:created)

      # Makes the request
      response =
        conn
        |> get(Routes.supplies_path(conn, :show, uuid))
        |> json_response(:ok)

      assert %{
               "supply" => %{
                 "description" => "TestSupply",
                 "expiration_date" => "2021-05-10",
                 "id" => _uuid,
                 "responsible" => "TestResponsible",
                 "restaurant_id" => _rid
               }
             } = response
    end
  end
end

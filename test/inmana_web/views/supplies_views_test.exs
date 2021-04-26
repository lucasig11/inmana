defmodule InmanaWeb.SuppliesViewTest do
  use InmanaWeb.ConnCase, async: true

  import Phoenix.View

  alias Inmana.Supply
  alias InmanaWeb.SuppliesView

  defp mock_restaurant(conn) do
    params = %{name: "TestRestaurant", email: "test@rest.com", password: "testpass"}

    conn
    |> post(Routes.restaurants_path(conn, :create, params))
    |> json_response(:created)
    |> Map.get("restaurant")
    |> Map.get("id")
  end

  describe "render/2" do
    test "renders create.json", %{conn: conn} do
      params = %{
        description: "TestSupply",
        responsible: "TestResponsible",
        expiration_date: "2021-05-10",
        restaurant_id: mock_restaurant(conn)
      }

      {:ok, supply} = Inmana.create_supply(params)

      response = render(SuppliesView, "create.json", supply: supply)

      assert %{
               message: "Supply succesfully registered!",
               supply: %Supply{
                 description: "TestSupply",
                 expiration_date: ~D[2021-05-10],
                 id: _sid,
                 responsible: "TestResponsible",
                 restaurant_id: _rid
               }
             } = response
    end

    test "renders show.json", %{conn: conn} do
      params = %{
        description: "TestSupply",
        responsible: "TestResponsible",
        expiration_date: "2021-05-10",
        restaurant_id: mock_restaurant(conn)
      }

      {:ok, supply} = Inmana.create_supply(params)

      response = render(SuppliesView, "show.json", supply: supply)

      assert %{
               supply: %Supply{
                 description: "TestSupply",
                 expiration_date: ~D[2021-05-10],
                 id: _uuid,
                 responsible: "TestResponsible",
                 restaurant_id: _rid
               }
             } = response
    end
  end
end

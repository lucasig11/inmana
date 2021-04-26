defmodule InmanaWeb.SuppliesController do
  use InmanaWeb, :controller

  alias Inmana.Supply
  alias InmanaWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Supply{} = supply} <- Inmana.create_supply(params) do
      conn
      |> put_status(:created)
      |> render("create.json", supply: supply)
    end
  end

  def show(conn, %{"id" => uuid}) do
    with {:ok, %Supply{} = supply} <- Inmana.get_supply(uuid) do
      conn
      |> put_status(:ok)
      |> render("show.json", supply: supply)
    end
  end

  def index(conn, _params) do
    {:ok, body, conn} = read_body(conn, [:restaurant_id])

    {:ok, %{"restaurant_id" => uuid}} = Jason.decode(body)

    supplies = Inmana.list_supplies(uuid)

    conn
    |> put_status(:ok)
    |> render("index.json", %{supplies: supplies})
  end
end

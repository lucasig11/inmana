defmodule Inmana.SupplyTest do
  use Inmana.DataCase

  alias Inmana.Supply

  describe "changeset/1" do
    test "should return a valid changeset with valid inputs" do
      params = %{
        description: "TestSupply",
        responsible: "TestResponsible",
        expiration_date: "2021-05-10",
        restaurant_id: "FakeRestaurant"
      }

      response = Supply.changeset(params)

      assert response.valid?
    end

    test "should return an invalid changeset with invalid inputs" do
      params = %{
        description: "",
        responsible: "",
        expiration_date: "2021-05-10",
        restaurant_id: "FakeRestaurant"
      }

      response = Supply.changeset(params)

      assert !response.valid?
    end
  end
end

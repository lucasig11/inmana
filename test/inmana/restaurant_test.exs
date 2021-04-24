defmodule Inmana.RestaurantTest do
  # Use the data sandbox
  use Inmana.DataCase, async: true

  alias Inmana.{Repo, Restaurant}

  describe "changeset/1" do
    test "should return a valid changeset on valid inputs" do
      params = %{name: "TestRestaurant", email: "test@rest.com"}

      response = Restaurant.changeset(params)

      assert response.valid?
    end

    test "shouldn't be able to register with an invalid name or e-mail address" do
      invalid_name = %{name: "1", email: "test@rest.com"}
      invalid_email = %{name: "ValidName", email: "invalidmail"}

      name_response = Restaurant.changeset(invalid_name)
      mail_response = Restaurant.changeset(invalid_email)

      assert !name_response.valid?
      assert !mail_response.valid?
    end

    test "shouldn't be able to register with empy fields" do
      invalid_name = %{name: "", email: "test@rest.com"}
      invalid_email = %{name: "ValidName", email: ""}

      name_response = Restaurant.changeset(invalid_name)
      mail_response = Restaurant.changeset(invalid_email)

      assert !name_response.valid?
      assert !mail_response.valid?
    end

    test "should return an invalid changeset on e-mail collision" do
      user_data = %{name: "TestRestaurant1", email: "test@rest.com"}
      imposter_data = %{name: "TestRestaurant2", email: "test@rest.com"}

      user = Restaurant.changeset(user_data)
      imposter = Restaurant.changeset(imposter_data)

      Repo.insert(user)

      assert {:error, changeset} = Repo.insert(imposter)
      assert {:email, ["has already been taken"]} in errors_on(changeset)
    end
  end
end

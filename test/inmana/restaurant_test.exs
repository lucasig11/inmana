defmodule Inmana.RestaurantTest do
  # Use the data sandbox
  use Inmana.DataCase, async: true

  alias Inmana.{Repo, Restaurant}

  describe "changeset/1" do
    test "should return a valid changeset on valid inputs" do
      params = %{name: "TestRestaurant", email: "test@rest.com", password: "testpassword"}

      response = Restaurant.changeset(params)

      assert response.valid?
    end

    test "shouldn't be able to register with an invalid name/password/address" do
      invalid_name = %{name: "1", email: "test@rest.com", password: "testpass"}
      invalid_email = %{name: "ValidName", email: "invalidmail", password: "testpass"}
      invalid_pass = %{name: "ValidName", email: "invalidmail", password: "inval"}

      name_response = Restaurant.changeset(invalid_name)
      mail_response = Restaurant.changeset(invalid_email)
      pass_response = Restaurant.changeset(invalid_pass)

      assert !name_response.valid?
      assert !mail_response.valid?
      assert !pass_response.valid?
    end

    test "shouldn't be able to register with empty fields" do
      invalid_name = %{password: "testpass", email: "test@rest.com"}
      invalid_email = %{name: "ValidName", password: "testpass"}
      invalid_pass = %{name: "ValidName", email: "test@rest.com"}

      name_response = Restaurant.changeset(invalid_name)
      mail_response = Restaurant.changeset(invalid_email)
      pass_response = Restaurant.changeset(invalid_pass)

      assert !name_response.valid?
      assert !mail_response.valid?
      assert !pass_response.valid?
    end

    test "should return an invalid changeset on e-mail collision" do
      user_data = %{name: "TestRestaurant1", email: "test@rest.com", password: "testpass"}
      imposter_data = %{name: "TestRestaurant2", email: "test@rest.com", password: "testpass"}

      user = Restaurant.changeset(user_data)
      imposter = Restaurant.changeset(imposter_data)

      Repo.insert(user)

      assert {:error, changeset} = Repo.insert(imposter)
      assert {:email, ["has already been taken"]} in errors_on(changeset)
    end
  end
end

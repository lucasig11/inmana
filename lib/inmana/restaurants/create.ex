defmodule Inmana.Restaurants.Create do
  import Ecto.Changeset

  alias Inmana.{Repo, Restaurant}
  alias Comeonin.Bcrypt

  def call(params) do
    params
    |> Restaurant.changeset()
    |> put_password_hash()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Restaurant{}} = result), do: result
  defp handle_insert({:error, result}), do: {:error, %{result: result, status: :bad_request}}

  def put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password, Bcrypt.hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end

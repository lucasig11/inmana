defmodule Inmana.Welcomer do
  def welcome(%{"name" => name, "age" => age}) do
    age = String.to_integer(age)

    name
    |> String.downcase()
    |> String.trim()
    |> evaluate(age)
  end

  defp evaluate("banana", 42) do
    {:ok, "You are very especial."}
  end

  defp evaluate(name, age) when age >= 18 do
    {:ok, "Welcome #{name}."}
  end

  defp evaluate(name, _age) do
    {:error, "#{name}, you're too young."}
  end
end

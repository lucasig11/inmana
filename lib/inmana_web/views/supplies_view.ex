defmodule InmanaWeb.SuppliesView do
  use InmanaWeb, :view

  def render("create.json", %{supply: supply}) do
    %{
      message: "Supply succesfully registered!",
      supply: supply
    }
  end

  def render("show.json", %{supply: supply}), do: %{supply: supply}

  def render("index.json", %{supplies: supplies}), do: %{supplies: supplies}
end

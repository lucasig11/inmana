defmodule Inmana.Supplies.ExpirationEmail do
  import Bamboo.Email

  alias Inmana.Supply

  def create(to_email, supplies) do
    new_email(
      to: to_email,
      from: "services@inmana.com",
      subject: "You have some supplies that are about to expire!",
      text_body: email_text(supplies)
    )
  end

  defp email_text(supplies) do
    initial_text = "---------- Supplies that are about to expire: ----------\n"

    # Enum.reduce([1, 2, 3, 4, 5], 0, fn elem, acc -> elem + acc)
    # >> 15
    Enum.reduce(supplies, initial_text, fn supply, text -> text <> supply_string(supply) end)
  end

  defp supply_string(%Supply{
         description: description,
         expiration_date: expiration_date,
         responsible: responsible
       }) do
    "Description: #{description}, Expiration date: #{expiration_date}, Responsible: #{responsible}\n"
  end
end

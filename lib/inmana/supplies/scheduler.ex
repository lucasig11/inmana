defmodule Inmana.Supplies.Scheduler do
  use GenServer

  alias Inmana.Supplies.NotifyExpiration

  def start_link(_state) do
    GenServer.start_link(__MODULE__, %{})
  end

  # @impl true tells the compiler we're implementing a behaviour, in this case it's from the GenServer behaviour
  # \\ sets a default value
  @impl true
  def init(state \\ %{}) do
    schedule_notification()
    {:ok, state}
  end

  @impl true
  def handle_info(:generate, state) do
    NotifyExpiration.send()
    schedule_notification()
    {:noreply, state}
  end

  defp schedule_notification do
    Process.send_after(self(), :generate, 1000 * 60 * 60 * 24 * 7)
  end
end
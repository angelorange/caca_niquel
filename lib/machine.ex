defmodule CacaNiquel.Machine do
  use GenServer

  def init(_args) do
    initial_state = %{
      balance: 100,
      reels: [],
      bet: 0
    }
    {:ok, initial_state}
  end

  def handle_call(:spin, _from, state) do
    new_reels = spin_reels()

    new_balance = calculate_balance(state.balance, state.bet, new_reels)

    new_state = %{state | reels: new_reels, balance: new_balance}
    {:reply, new_state, new_state}
  end

  def handle_cast({:bet, amount}, state) do
    new_state = %{state | bet: amount}
    {:noreply, new_state}
  end

  defp spin_reels do
    Enum.map(1..3, fn _ -> Enum.random(["🍒", "🍋", "🔔", "💎", "7️⃣"]) end)
  end

  defp calculate_balance(balance, bet, reels) do
    payout_table = %{
      "🍒" => 2,
      "🔔" => 5,
      "💎" => 10,
      "7️⃣" => 20
    }

    case Enum.uniq(reels) do
      [symbol] ->
        payout = Map.get(payout_table, symbol, 0)
        balance + (bet * payout)
      _ ->
        balance - bet
    end
  end
end

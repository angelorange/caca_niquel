# Caça Níquel

### Creating a slot machine simulator for studying probability.

```elixir
iex> {:ok, pid} = GenServer.start_link(CacaNiquel.Machine, [])
{:ok, #PID<0.123.0>}

iex> GenServer.cast(pid, {:bet, 10})
:ok

iex> GenServer.call(pid, :spin)
%{
  balance: 90,
  reels: ["🍒", "🍒", "🍋"],
  bet: 10
}

```

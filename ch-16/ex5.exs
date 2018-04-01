defmodule Ex5 do
  use GenServer

  ## external API

  def start_link(intval) do
    GenServer.start_link(__MODULE__, intval, name: __MODULE__)
  end

  def pop() do
    GenServer.call(__MODULE__, :pop)
  end

  def push(item) do
    GenServer.cast(__MODULE__, {:push, item})
  end

  ## gen server imp

  def init(args) do
    {:ok, Enum.reverse(args)}
  end

  # def handle_call(:pop, _, []) do
  #   {:reply, nil, []}
  # end

  def handle_call(:pop, _, [ head | rest ]) do
    {:reply, head, rest}
  end

  def handle_cast({:push, item}, list) do
    {:noreply, [item | list]}
  end

  def terminate(reason, state) do
    IO.puts "in terminate callback"
    IO.puts inspect reason
    System.halt(1)
  end
end


{:ok, _} = Ex5.start_link([5, "cat", 9])
# Ex5.push(4)

Enum.each 1..4, fn _ ->
  IO.puts Ex5.pop()
end




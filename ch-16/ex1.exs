defmodule Ex1 do
  use GenServer

  def init(args) do
    {:ok, args}
  end

  def handle_call(:pop, _, [ head | rest ]) do
    {:reply, head, rest}
  end
end


{:ok, pid} = GenServer.start_link(Ex1, [5, "cat", 9])

Enum.each 1..3, fn _ ->
  IO.puts GenServer.call(pid, :pop)
end



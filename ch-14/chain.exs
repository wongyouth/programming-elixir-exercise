defmodule Chain do
  def counter(prev_pid) do
    receive do
      n ->
        send prev_pid, n+1
    end
  end

  def create_processes(n) do
    last = Enum.reduce 1..n, self(),
      fn(_, prev_pid) ->
        spawn Chain, :counter, [prev_pid]
      end

    send last, 0

    receive do
      n ->
        "Result #{n}"
    end
  end


  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end

# Chain.run(10)

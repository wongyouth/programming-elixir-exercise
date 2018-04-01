defmodule Spawn1 do
  def greet do
    receive do
      {sender, msg} ->
        send sender, {:ok, "Hello #{msg}"}
        greet
    end
  end
end

pid = spawn(Spawn1, :greet, [])
send pid, {self(), "Ryan"}

receive do
  {:ok, msg} ->
    IO.puts msg
end

send pid, {self(), "World"}

receive do
  {:ok, msg} ->
    IO.puts msg
  after 500 ->
    IO.puts "timeout"
end


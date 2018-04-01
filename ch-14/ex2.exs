defmodule Ex2 do
  def reply(sender) do
    IO.puts inspect self()

    receive do
      msg ->
        send sender, {:ok, msg}
    end
  end

  def create_processes do
    pid = spawn Ex2, :reply, [self()]
    # IO.puts "fred: #{pid}"
    send pid, ["fred"]
    pid = spawn Ex2, :reply, [self()]
    # IO.puts "betty: #{pid}"
    send pid, ["betty"]

    receive do
      {:ok, msg} ->
        IO.puts msg
    end

  end

end

Ex2.create_processes()

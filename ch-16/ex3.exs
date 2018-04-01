defmodule Ex3 do
	use GenServer

	def init(args) do
		{:ok, Enum.reverse(args)}
	end

	def handle_call(:pop, _, []) do
		{:reply, nil, []}
	end

	def handle_call(:pop, _, [ head | rest ]) do
		{:reply, head, rest}
	end

	def handle_cast({:push, item}, list) do
		{:noreply, [item | list]}
	end
end


{:ok, _} = GenServer.start_link(Ex3, [5, "cat", 9], name: :stack)
GenServer.cast(:stack, {:push, 4})

Enum.each 1..4, fn _ ->
	IO.puts GenServer.call(:stack, :pop)
end



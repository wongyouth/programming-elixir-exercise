defmodule Stack.Server do
	use GenServer

	@svn "0"

	alias Stack.Stash

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

	def init(_) do
		{:ok, Stash.get()}
	end

	def terminate(_reason, state) do
		Stash.save(state)
	end
	
	# def handle_call(:pop, _, []) do
	# 	{:reply, nil, []}
	# end

	def handle_call(:pop, _, [ head | rest ]) do
		{:reply, head, rest}
	end

	def handle_cast({:push, item}, list) do
		{:noreply, [item | list]}
	end

end


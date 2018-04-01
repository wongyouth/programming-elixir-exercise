defmodule Stack.Stash do
	use GenServer

	def start_link(args \\ []) do
		GenServer.start_link(__MODULE__, args, name: __MODULE__)
	end

	def init(args) do
		{:ok, Enum.reverse(args)}
	end

	def get() do
		GenServer.call(__MODULE__, :get)
	end

	def save(list) do
		GenServer.cast(__MODULE__, {:save, list})
	end

	def handle_call(:get, _from, list) do
		{:reply, list, list}
	end

	def handle_cast({:save, list}, _) do
		{:noreply, list}
	end
end
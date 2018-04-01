defmodule Ex3 do
	def child(pid) do
		send pid, {:ok, "die"}
		exit(:boom)
		# raise "boom"
	end

	def process do
		spawn_link Ex3, :child, [self()]
		# spawn_monitor Ex3, :child, [self()]

		:timer.sleep(500)

		waiting()
	end

	def waiting do
		receive do
			{:ok, msg} ->
				IO.puts "Receive #{msg}"
			msg ->
				IO.puts inspect msg
		end

		waiting()

	end
end

Ex3.process()
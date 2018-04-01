defmodule E5 do
	def all?([], _) do
		true
	end

	def all?([head | tail], f) do
		f.(head) && all?(tail, f)
	end

	def each(list, f) do
		for i <- list do
			f.(i)
		end

		:ok
	end

	def filter([], _) do
		[]
	end

	def filter([head | tail], f) do
		if f.(head) do
			[head | filter(tail, f)]
		else
			filter(tail, f)
		end
	end


	def split(list, n) do

		n2 =
			cond do
				n < 0 -> max(length(list) + n, 0)
				true -> n
			end

		_split([], list, n2)

	end

	defp _split(list, [head | tail], n) when n > 0 do
		_split(list ++ [head], tail, n-1)
	end

	defp _split(left, right, _n) do
		[left, right]
	end


	def take([head | tail], n) when n > 0 do
		[head | take(tail, n-1)]
	end

	def take([head | tail], n) when n < 0 do
		[take(head, n+1), tail]
	end

	def take(_, _) do
		[]
	end
end

defmodule E6 do
	def flatten([head | tail]) when is_list(head) do
		flatten(head) ++ flatten(tail)
	end

	def flatten([head | tail])do
		[head] ++ flatten(tail)
	end

	def flatten([]) do
		[]
	end
end

defmodule E7 do
	
end

defmodule E8 do
	def f(tax_rates, orders) do
		for order <- orders do
			case Keyword.fetch(tax_rates, order[:ship_to]) do
				{:ok, value} = tax ->
					order ++ [total_amount: order[:net_amount] * (1+value)]
					IO.puts tax[1]
				_ ->
					order ++ [total_amount: order[:net_amount]]
			end
		end
	end
end
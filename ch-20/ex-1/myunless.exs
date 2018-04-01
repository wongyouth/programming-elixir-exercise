defmodule My do
	defmacro myunless(condition, clauses) do
		do_clause = Keyword.get clauses, :do, nil
		else_clause = Keyword.get clauses, :else, nil

		quote do
			case unquote(condition) do
				val when val in [false, nil] -> unquote(do_clause)
				_ -> unquote(else_clause)
			end
		end
	end
end

defmodule MyTest do
	require My

	IO.inspect My.myunless 1 == 1, do: '1 != 1', else: '1 == 1'
	IO.inspect My.myunless 1 == 2, do: '1 != 2', else: '1 == 2'
end
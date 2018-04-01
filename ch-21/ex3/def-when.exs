defmodule Tracer do
	def dump_defn(args) do
		args |> Enum.map(&inspect/1) |> Enum.join(", ")
	end

	def dump_defn(name, args) do
		"#{name}(#{dump_defn(args)})"
	end
	
	defmacro def({:when, _, [{name, _, args}, _]}=definition, do: content) do
	    # IO.inspect definition
	    _def(definition, name, args, content)
	end

	defmacro def({name, _, args}=definition, do: content) do
	    # IO.inspect definition
	    _def(definition, name, args, content)
	end

	defp _def(definition, name, args, content) do
		quote do
			Kernel.def unquote(definition) do
				# IO.inspect(unquote(definition))
				IO.puts "\e[31m===> call: \e[0m#{Tracer.dump_defn(unquote(name), unquote(args))}"
				result = unquote(content)
				IO.puts "\e[32m<=== result: \e[0m#{result}"
				result
			end
		end	
	end

	defmacro __using__(_opts) do
		quote do
			import Kernel, except: [def: 2]
			import Tracer, only: [def: 2]
		end
	end
end

defmodule Test do
	use Tracer

	def puts_sum_three(a,b,c) when a > 5, do: IO.inspect(a-5+b+c)
	def puts_sum_three(a,b,c), do: IO.inspect(a+b+c)
	def add_list(list), do: Enum.reduce(list, 0, &(&1+&2))
end

Test.puts_sum_three(1,2,3)
Test.puts_sum_three(6,2,3)
Test.add_list([5,6,7,8])

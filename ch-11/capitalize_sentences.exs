defmodule Ch11 do
	def capitalize_sentences(s) do
		_capitalize_sentences(s, true)
	end

	defp _capitalize_sentences(<< ?. :: utf8, ?\  :: utf8, rest :: binary >>, _)do
		". " <> _capitalize_sentences(rest, true )
	end

	defp _capitalize_sentences(<<>>, _)do
		""
	end

	defp _capitalize_sentences(<< head :: utf8, rest :: binary >>, true) do
		String.upcase(<< head :: utf8 >>) <> _capitalize_sentences(rest, false)
	end

	defp _capitalize_sentences(<< head :: utf8, rest :: binary >>, false)do
		String.downcase(<< head :: utf8 >>) <> _capitalize_sentences(rest, false )
	end

end

IO.puts Ch11.capitalize_sentences("oh. a DOG. woof. ")
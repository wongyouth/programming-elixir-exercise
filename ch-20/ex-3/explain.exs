defmodule Explain do

  @ops %{
    :+ => "add",
    :- => "subtract",
    :* => "multiply",
    :/ => "divide"
  }

  defmacro explain(do: expression) do
    {_, translated_expression} = Macro.postwalk(expression, [], fn
      {op, _, [left, right]}, acc when is_number(left) and is_number(right) ->
        translate = "#{@ops[op]} #{left} and #{right}"
        {"", acc ++ [translate]} 
      {op, _, [left, _right]}, acc when is_number(left) ->
        translate = "then #{@ops[op]} #{left}"
        {"", acc ++ [translate]} 
      {op, _, [_left, right]}, acc when is_number(right) ->
        translate = "then #{@ops[op]} #{right}"
        {"", acc ++ [translate]}
      other, acc ->
        {other, acc}

    end)

    translated_expression
    |> Enum.join(", ")
  end
end


defmodule ExplainTest do
  require Explain

  IO.puts Explain.explain do: 2 + 3 * 4
  IO.puts Explain.explain do: 2 + 3 * 4 + 5
end

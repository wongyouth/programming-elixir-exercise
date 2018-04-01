defmodule Cypher do
  def encrypt([], _shift) do
    []
  end

  def encrypt([head | rest], shift) when head >= ?a and head <= ?z do
    enc = rem(head - ?a + shift, 26) + ?a

    [enc | encrypt(rest, shift)]
  end

  def encrypt([head | rest], shift) when head >= ?A and head <= ?Z do
    enc = rem(head - ?A + shift, 26) + ?A

    [enc | encrypt(rest, shift)]
  end

  def encrypt([head | rest], shift) do
    [head | encrypt(rest, shift)]
  end
end


defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Caesar, for: List do
  def encrypt(string, shift) do
    Cypher.encrypt(string, shift)
  end

  def rot13(string) do
    encrypt(string, 13)
  end
end

defimpl Caesar, for: BitString do
  def encrypt(string, shift) do
    string |> to_charlist |> Cypher.encrypt(shift)
  end

  def rot13(string) do
    encrypt(string, 13)
  end
end

IO.puts Caesar.encrypt("abCDz", 1) # bcDEa
IO.puts Caesar.encrypt('abCDz', 1) # bcDEa

IO.puts Caesar.rot13("abcDN") # nopQA
IO.puts Caesar.rot13('abcDN') # nopQA

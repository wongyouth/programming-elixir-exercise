defmodule Ch11 do
  def printable?([]) do
    true
  end

  def printable?([head | tail]) do
    head >= ?\  and head <= ?~ and printable?(tail)
  end
end

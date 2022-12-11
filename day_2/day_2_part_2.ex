defmodule ScoreCalculator do
  def decrypt(choice) do
    opponent = case choice do
      [x, _] when x == "A"  -> :rock
      [x, _] when x == "B"  -> :paper
      [x, _] when x == "C"  -> :scissor
    end

    case choice do
      [_, y] when y == "X" and opponent == :rock -> [opponent, :scissor]
      [_, y] when y == "X" and opponent == :paper -> [opponent, :rock]
      [_, y] when y == "X" and opponent == :scissor -> [opponent, :paper]
      [_, y] when y == "Y" -> [opponent, opponent]
      [_, y] when y == "Z" and opponent == :rock -> [opponent, :paper]
      [_, y] when y == "Z" and opponent == :scissor -> [opponent, :rock]
      [_, y] when y == "Z" and opponent == :paper -> [opponent, :scissor]
    end
  end


  def calculate(round) do
    values = %{rock: 1, paper: 2, scissor: 3}

    decrypted =
      String.split(round, " ")
      |> Enum.map(fn x -> x |> String.trim() end)
      |> decrypt()

    case decrypted do
      [x, y] when x == y -> 3 + values[y]
      [:rock, :paper] -> 6 + values.paper
      [:paper, :scissor] -> 6 + values.scissor
      [:scissor, :rock] -> 6 + values.rock
      [:rock, :scissor] -> values.scissor
      [:paper, :rock] -> values.rock
      [:scissor, :paper] -> values.paper
      _ -> 0
    end
  end

  def main do
    File.stream!("./input.text")
    |> Enum.map(fn l -> calculate(l) end)
    |> Enum.sum()
    |> IO.inspect()
  end
end

ScoreCalculator.main()

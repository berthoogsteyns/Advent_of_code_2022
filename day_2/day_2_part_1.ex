defmodule ScoreCalculator do
  def decrypt(choice) do
    case choice do
      x when x == "A" or x == "X" -> :rock
      x when x == "B" or x == "Y" -> :paper
      x when x == "C" or x == "Z" -> :scissor
    end
  end

  def calculate(round) do
    values = %{rock: 1, paper: 2, scissor: 3}

    decrypted =
      String.split(round, " ")
      |> Enum.map(fn x -> x |> String.trim() |> decrypt() end)

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

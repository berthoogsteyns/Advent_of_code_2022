defmodule CaloryCounter do
  def count(file) do
    file
    |> String.split("\n\n")
    |> Enum.map(fn calories ->
      String.split(calories, "\n")
      |> Enum.reduce(0, fn x, acc ->
        case Integer.parse(x) do
          {i, _} -> acc + i
          _ -> acc
        end
      end)
    end)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
    |> IO.inspect()
  end

  def main do
    case File.read("./input.txt") do
      {:ok, body} ->
        count(body)

      {:error, reason} ->
        IO.puts(reason)
    end
  end
end

CaloryCounter.main()

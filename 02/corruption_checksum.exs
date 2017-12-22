defmodule CorruptionChecksum do
  def run do
    input = File.stream!("#{__DIR__}/input.txt")
            |> Enum.to_list()

    IO.puts "Min max checksum: #{min_max_checksum(input)}"
    IO.puts "Divide checksum: #{divide_checksum(input)}"
  end

  defp min_max_checksum(list) do
    list
    |> Enum.reduce(0, fn(line, acc) -> 
      acc + (parse_line(line) |> min_max_diff())
    end)
  end

  defp divide_checksum(list) do
    list
    |> Enum.reduce(0, fn(line, acc) -> 
      acc + (parse_line(line) |> divide_line())
    end)
  end

  defp parse_line(line) do
    line
    |> String.split(~r/\s/)
    |> Enum.filter(fn(num) -> String.match?(num, ~r/\d+/) end)
    |> Enum.map(&String.to_integer/1)
  end

  defp min_max_diff(line) do
    {a, b} = Enum.min_max(line)
    b - a
  end

  defp divide_line(line) do
    line
    |> get_pairs()
    |> Enum.find(fn(pair) -> even_divide?(pair) end)
    |> divide()
  end

  defp get_pairs(line) do
    IO.inspect line
    x = for a <- line, b <- tl(line), a != b, do: Enum.sort([a, b])
    Enum.uniq(x)
  end

  defp even_divide?([a | [b]]), do: (rem(a, b) == 0) || (rem(b, a) == 0)
  # defp even_divide?([a | b]), do: IO.inspect a; IO.inspect b #(rem(a, b) == 0) || (rem(b, a) == 0)

  defp divide([a | [b]]), do: div(Enum.max([a, b]), Enum.min([a, b]))
end

CorruptionChecksum.run

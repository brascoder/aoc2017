defmodule InverseCaptcha do
  def run do
    input = "#{__DIR__}/input.txt"
            |> parse_input_file

    IO.puts "Sum next: #{sum_next(input)}"
    IO.puts "Sum across: #{sum_across(input)}"
  end

  defp parse_input_file(input) do
    input
    |> File.read!()
    |> String.replace(~r/\D/, "")
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  defp sum_next(list) do
    list
    |> Enum.chunk_every(2, 1, [hd(list)])
    |> Enum.reduce(0, fn([a | [b]], acc) ->
      case a == b do
        true  -> acc + a
        false -> acc
      end
    end)
  end

  defp sum_across(list) do
    halfway = div(length(list), 2) + 1

    list
    |> Enum.chunk_every(halfway, 1, [hd(list)])
    |> Enum.reduce(0, fn(half, acc) ->
      case hd(half) == List.last(half) do
        true  -> acc + (hd(half) * 2)
        false -> acc
      end
    end)
  end
end

InverseCaptcha.run

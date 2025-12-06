lines = File.stream!("input") |> Enum.to_list()

p1_lines =
  lines
  |> Enum.map(&String.trim/1)
  |> Enum.map(&String.split(&1, ~r/\s+/))

signs = Enum.at(p1_lines, -1)

p1_lines = Enum.slice(p1_lines, 0, Enum.count(p1_lines) - 1)
lines = Enum.slice(lines, 0, Enum.count(lines) - 1)

p1 =
  Enum.with_index(signs)
  |> Stream.map(fn {v, i} ->
    nums = p1_lines |> Enum.map(fn l -> Enum.at(l, i) |> String.to_integer() end)

    case String.trim(v) do
      "+" -> nums |> Enum.sum()
      "*" -> nums |> Enum.product()
      _ -> 0
    end
  end)
  |> Enum.sum()

len = lines |> Enum.at(0) |> String.length()

p2_nums =
  0..(len - 1)
  |> Enum.map(fn index ->
    case Enum.map(lines, fn line -> String.at(line, index) end)
         |> Enum.join()
         |> String.trim() do
      "" -> 0
      v -> String.to_integer(v)
    end
  end)
  |> Enum.chunk_by(fn i -> i == 0 end)
  |> Enum.reject(fn i -> i == [0] end)

p2 =
  Enum.with_index(signs)
  |> Enum.map(fn {sign, index} ->
    nums = Enum.at(p2_nums, index)

    case sign do
      "+" -> Enum.sum(nums)
      "*" -> Enum.product(nums)
      _ -> 0
    end
  end)
  |> Enum.sum()

IO.puts(p1)
IO.puts(p2)

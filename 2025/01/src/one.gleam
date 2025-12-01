import gleam/int
import gleam/io
import gleam/result
import gleam/string
import simplifile

pub fn main() {
  let start_pos = 50
  let codes =
    simplifile.read("input")
    |> result.unwrap("")
    |> string.trim
    |> string.split("\n")

  let #(p1, p2) = puzzle(codes, start_pos, 0, 0)

  int.to_string(p1) |> io.println
  int.to_string(p2) |> io.println
}

pub fn puzzle(moves: List(String), pos: Int, p1: Int, p2: Int) -> #(Int, Int) {
  case moves {
    [first, ..rest] -> {
      let new_pos = case first {
        "L" <> num -> {
          let num = int.parse(num) |> result.unwrap(0)
          case { pos - num % 100 } % 100 {
            i if i < 0 -> 100 + i
            i if i >= 0 -> i
            _ -> -1
          }
        }
        "R" <> num -> {
          let num = int.parse(num) |> result.unwrap(0)
          { pos + num % 100 } % 100
        }
        _ -> -1
      }

      let new_p2 = case first {
        "L" <> num -> {
          let num = int.parse(num) |> result.unwrap(0)
          case pos - num {
            _ if pos == 0 -> p2 + num / 100
            i if i <= 0 -> p2 + 1 + { num - pos } / 100
            _ -> p2
          }
        }
        "R" <> num -> {
          let num = int.parse(num) |> result.unwrap(0)
          p2 + { pos + num } / 100
        }
        _ -> p2
      }

      case new_pos {
        0 -> puzzle(rest, new_pos, p1 + 1, new_p2)
        _ -> puzzle(rest, new_pos, p1, new_p2)
      }
    }
    [] -> #(p1, p2)
  }
}

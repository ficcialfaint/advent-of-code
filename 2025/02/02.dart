import 'dart:io';

bool check_p1(int num) {
  var str = num.toString();

  if (str.length % 2 != 0) return false;

  var l = str.substring(0, str.length ~/ 2);
  var r = str.substring(str.length ~/ 2);

  if (l == r) return true;
  return false;
}

bool check_p2(int num) {
  var str = num.toString();
  var len = str.length;

  var n = 0;
  while (n < len ~/ 2) {
    n += 1;
    if (str.substring(0, n).allMatches(str).length * n == len) return true;
  }
  return false;
}

void main() async {
  var ranges = (await File('input').readAsString())
      .trim()
      .split(',')
      .map((s) => (int.parse(s.split("-")[0]), int.parse(s.split("-")[1])));

  var p1 = 0;
  var p2 = 0;

  for (var (left, right) in ranges) {
    for (var num in List.generate(right - left + 1, (i) => i + left)) {
      if (check_p1(num)) p1 += num;
      if (check_p2(num)) p2 += num;
    }
  }
  print(p1);
  print(p2);
}

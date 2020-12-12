import 'file_utils.dart';

class PwSpec {
  final int min;
  final int max;
  final String char;
  final String pw;

  PwSpec(this.min, this.max, this.char, this.pw);

  @override
  String toString() => "PwSpec($min, $max, $char, $pw)";
}

void main() async {
  final answer = await readLines('puzzle_3_input.txt')
    .map(parseLine)
    .map(checkSpec)
    .fold(0, add);

  print("answer is $answer");
}

RegExp _regExp = new RegExp(r"(\d+)-(\d+) ([a-zA-Z]): (\w+)");

PwSpec parseLine(String line) {
  RegExpMatch match = _regExp.firstMatch(line);
  final xs = match.groups([1, 2, 3, 4]);
  return PwSpec(int.parse(xs[0]), int.parse(xs[1]), xs[2], xs[3]);
}

int checkSpec(PwSpec spec) => (spec.pw.split(spec.char).length - 1).isBetween(spec.min, spec.max) ? 1 : 0;

extension on int {
  bool isBetween(int min, int max) => this >= min && this <= max;
}

int add(sum, n) => sum += n;
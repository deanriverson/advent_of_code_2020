import '../file_utils.dart';

class PwSpec {
  final int min;
  final int max;
  final String char;
  final String pw;

  PwSpec(this.min, this.max, this.char, this.pw);

  @override
  String toString() => 'PwSpec($min, $max, $char, $pw)';
}

void puzzle_2b() async {
  final answer = await readLines('puzzle_2_input.txt').map(parseLine).map(checkSpec).fold(0, add);
  print('Puzzle 2b answer is: $answer');
}

RegExp _regExp = RegExp(r'(\d+)-(\d+) ([a-zA-Z]): (\w+)');

PwSpec parseLine(String line) {
  var match = _regExp.firstMatch(line);
  final xs = match.groups([1, 2, 3, 4]);
  return PwSpec(int.parse(xs[0]), int.parse(xs[1]), xs[2], xs[3]);
}

int checkSpec(PwSpec spec) {
  try {
    final char1 = spec.pw[spec.min - 1] == spec.char;
    final char2 = spec.pw[spec.max - 1] == spec.char;
    return char1 ^ char2 ? 1 : 0;
  } catch (e) {
    print('Error ${e.toString()} for spec: $spec');
    return 0;
  }
}

int add(sum, n) => sum += n;

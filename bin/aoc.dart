import 'package:aoc/aoc.dart';
import 'package:aoc/args.dart';

void main(List<String> arguments) {
  final puzzlesToRun = parseArgs(arguments);
  print('puzzles to run: $puzzlesToRun');
  if (puzzlesToRun == null) return;

  runPuzzles(puzzlesToRun);
}
